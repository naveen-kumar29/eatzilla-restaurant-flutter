import 'package:custom_tabbar/Foodlist/model/foodlist_model.dart';
import 'package:custom_tabbar/Orders/order_widgets.dart';
import 'package:custom_tabbar/Utils/app_loader.dart';
import 'package:custom_tabbar/Utils/app_strings.dart';
import 'package:custom_tabbar/Utils/constants.dart';
import 'package:custom_tabbar/Utils/flutter_toast.dart';
import 'package:custom_tabbar/Utils/network_service.dart';
import 'package:custom_tabbar/Utils/url_generator.dart';
import 'package:custom_tabbar/restaurant_available_widget.dart';
import 'package:flutter/material.dart';

import '../Utils/app_colors.dart';

class FoodManagement extends StatefulWidget {
  const FoodManagement({super.key});

  @override
  State<FoodManagement> createState() => _ManagementViewState();
}

class _ManagementViewState extends State<FoodManagement> {
  final GlobalKey _keyLoaderDialog = GlobalKey();

  @override
  void initState() {
    super.initState();
    _getFoodLsit();
  }

  _getFoodLsit() {
    _foodDetails = getRestaurantFoodList(Resource(url: Urls.getFoodList));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            '',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: false,
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: FutureBuilder<FoodListResponse>(
          future: _foodDetails,
          builder: (context, snapshot) {
            return _handleOrderResponse(snapshot);
          },
        ));
  }

  _handleOrderResponse(AsyncSnapshot<FoodListResponse> snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.done:
        var foodDetails = snapshot.data?.details;
        return (snapshot.hasData && foodDetails != null)
            ? _bodyWidget(snapshot.data!.details!)
            : noDataView(kNoDataFound, textColor: kPrimaryColor);
      default:
        return loaderWidget(valueColor: kPrimaryColor);
    }
  }

  _bodyWidget(List<FoodCategoryDetails> foodList) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(12, 5, 10, 0),
          child: RestaurantWidget(),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                ),
                child: ListView.builder(
                    itemCount: foodList.length,
                    shrinkWrap: true,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(12, 5, 12, 0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                foodList[index].categoryName ?? '',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 15),
                              SizedBox(
                                height:
                                (foodList[index].items?.length ?? 0) * 70,
                                child: _foodListWidget(
                                    foodList[index].items ?? []),
                              )
                            ],
                          ),
                        ),
                      );
                    })),
              ),
            ),
          ),
        )
      ],
    );
  }

  _foodListWidget(List<Items> foodList) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount: foodList.length,
      itemBuilder: ((context, index) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.circle_rounded,
                            color: foodList[index].isVeg == 0
                                ? Colors.red
                                : Colors.green,
                            size: 16,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            foodList[index].name ?? '',
                            style: const TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(35, 0, 8, 8),
                      child: Text(''),
                          style: const TextStyle(fontSize: 16)),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}