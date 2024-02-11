class Product{
  int? id;
  String name;
  String code;
  double price;
  int quantity;

  Product.fromJson(Map json):
    id=json['id'],
    name=json['name'],
    code=json['code'],
    price=json['price'],
    quantity=json['quantity'] ?? 0;

  Map<String,dynamic> toJson()=>{
    "id":id,
    "name":name,
    'code':code,
    "price":price,
    "quantity":quantity
  };
}