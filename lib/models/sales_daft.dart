class SalesDraft{
  late int id;
  late String title;
  List<SalesDraftItem> items =[];

  SalesDraft({required this.id,required this.title});

  SalesDraft.fromJson(Map json){
    id = json['id'];
    title = json['title'];
    items = _getItems(json['items']);
  }

  Map toJson()=>{
    'id': id,
    'title': title,
    'items': items.map((item) => item.toJson()).toList()
  };

  List<SalesDraftItem> _getItems(List json){
    List<SalesDraftItem> itms =[];
    for (var item in json) {
      items.add(SalesDraftItem.fromJson(item));
    }
    return itms;
  }
  
}

class SalesDraftItem{
  String name;
  String code;
  double price;
  int quantity;

  SalesDraftItem.fromJson(Map json):
    name = json['name'],
    code = json['code'],
    price = json['price'],
    quantity = json['quantity'];    
  

  Map toJson()=>{
    'name': name,
    'code': code,
    'price': price,
    'quantity': quantity
  };
}