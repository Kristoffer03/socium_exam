class ProductListModel {
  ProductListModel({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });
  late final List<Products> products;
  late final int total;
  late final int skip;
  late final int limit;

  ProductListModel.fromJson(Map<String, dynamic> json){
    products = List.from(json['products']).map((e)=>Products.fromJson(e)).toList();
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['products'] = products.map((e)=>e.toJson()).toList();
    _data['total'] = total;
    _data['skip'] = skip;
    _data['limit'] = limit;
    return _data;
  }
}

class Products {
  Products({
    required this.id,
    required this.title,
    required this.price,
    required this.thumbnail,
    required this.stock,
    required this.discountPercentage,
  });
  late final int id;
  late final String title;
  late final int price;
  late final String thumbnail;
  late final int stock;
  late final double discountPercentage;

  Products.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    price = json['price'];
    thumbnail = json['thumbnail'];
    stock = json['stock'];
    discountPercentage = json['discountPercentage'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['price'] = price;
    _data['thumbnail'] = thumbnail;
    _data['stock'] = stock;
    _data['discountPercentage'] = discountPercentage;
    return _data;
  }
}