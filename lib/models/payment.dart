class Payment{
  String code;
  String account;
  String type;
  double amount;

  Payment.fromJson(Map json):
    code = json['code'] ?? '',
    account = json['account'] ?? '',
    type = json['type'] ?? '',
    amount = json['amount'] ?? 0.0;

  Map toJson()=>{
    'code': code,
    'account': account,
    'type': type,
    'amount': amount
  };
}