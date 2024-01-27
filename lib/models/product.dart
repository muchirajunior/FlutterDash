
class Product{
  int? id;
  String? name;
  String? code;
  String? description;
  double? price;
  int quantity;
 

  Product.fromJson(Map json):
    id=json['id'],
    name=json['name'],
    code=json['ItemCode'],
    description=json['description'],
    price=json['price'],
    quantity=json['quantity'] ?? 0;

  Map<String,dynamic> toJson()=>{
    "id":id,
    "name":name,
    'description':description,
    "price":price,
    "quantity":quantity
  };
}