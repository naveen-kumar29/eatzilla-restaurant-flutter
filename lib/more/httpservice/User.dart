import 'dart:convert';
List<PayoutDetails> userFromJson(String str) => List<PayoutDetails>.from(json.decode(str).map((x) => PayoutDetails.fromJson(x)));
String userToJson(List<PayoutDetails> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class PayoutDetails {
  PayoutDetails({
    required this.status,
    required this.details,
    required this.pending_payout,
  });
  bool status;
  List<Details> details;
  double pending_payout;

  factory PayoutDetails.fromJson(Map<String, dynamic> json) => PayoutDetails(
    status: json["status"],
    details: json["details"],
    pending_payout: json["pending_payout"],
  );
  Map<String, dynamic> toJson() => {
    "status": status,
    "details": details,
    "pending_payout": pending_payout,
  };
}
class Details {
  Details({
    required this.id,
    required this.restaurant_id,
    required this.payout_amount,
    required this.description,
    required this.transaction_id,
    required this.status,
    required this.from_date,
    required this.to_date,
    required this.created_at,
    required this.updated_at,
    required this.merchant_ref_no,
    required this.trans_status,
    required this.payout_trans_id,
    required this.trans_datetime,
    required this.failure_remark,
  });
  int id;
  int restaurant_id;
  int payout_amount;
  String description;
  String transaction_id;
  String status;
  String from_date;
  String to_date;
  String created_at;
  String updated_at;
  String merchant_ref_no;
  String trans_status;
  String payout_trans_id;
  String trans_datetime;
  String failure_remark;
  factory Details.fromJson(Map<String, dynamic> json) => Details(
    id: json["id"],
    restaurant_id: json["restaurant_id"],
    payout_amount: json["payout_amount"],
    description: json["description"],
    transaction_id: json["transaction_id"],
    status: json["status"],
    from_date: json["from_date"],
    to_date: json["to_date"],
    created_at: json["created_at"],
    updated_at: json["updated_at"],
    merchant_ref_no: json["merchant_ref_no"],
    trans_status: json["trans_status"],
    payout_trans_id: json["payout_trans_id"],
    trans_datetime: json["trans_datetime"],
    failure_remark: json["failure_remark"],
  );
  Map<String, dynamic> toJson() => {
    "id": id,
    "restaurant_id": restaurant_id,
    "payout_amount": payout_amount,
    "description": description,
    "transaction_id": transaction_id,
    "status": status,
    "from_date": from_date,
    "to_date": to_date,
    "created_at": created_at,
    "updated_at": updated_at,
    "merchant_ref_no": merchant_ref_no,
    "trans_status": trans_status,
    "payout_trans_id": payout_trans_id,
    "trans_datetime": trans_datetime,
    "failure_remark": failure_remark,
  };
}