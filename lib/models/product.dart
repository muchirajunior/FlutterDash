
class Product{
  int? id;
  String? name;
  double? price;
  int? quantity;

  Product.fromJson(Map json):
    id=json['id'],
    name=json['name'],
    price=json['price'],
    quantity=json['quatity'];

  Map toJson()=>{
    "id":id,
    "name":name,
    "price":price,
    "quantity":quantity
  };
}