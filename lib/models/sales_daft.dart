class SalesDraft{
  int? id;
  String? title;
  List<SalesDraftItem> items =[];
  
}

class SalesDraftItem{
  String? item;
  String? code;
  double? price;
  int? quantity;
}