
class Product{
  int? id;
  String? name;
  String? description;
  double? price;
  int? quantity;
  int sellQuantity=1;

  Product.fromJson(Map json):
    id=json['id'],
    name=json['name'],
    description=json['description'],
    price=json['price'],
    quantity=json['quantity'];

  Map<String,dynamic> toJson()=>{
    "id":id,
    "name":name,
    'description':description,
    "price":price,
    "quantity":quantity
  };
}