class HomeModel {
  late bool status;
  late String? message;
  DataModel? data;
  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? DataModel.fromJson(json['data']) : null;
  }
}

class DataModel {
  List<bannerModel> banners = [];
  List products = [];

  DataModel.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((v) {
      banners.add(new bannerModel.fromJson(v));
    });
    json['products'].forEach((v) {
      products.add(new productModel.fromJson(v));
    });
  }
}

class bannerModel {
  late int id;
  late String image;
  late dynamic category;
  late dynamic product;
  bannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    category = json['category'];
    product = json['product'];
  }
}

class productModel {
  int? id;
  dynamic? price;
  dynamic? oldPrice;
  dynamic? discount;
  String? image;
  String? name;
  String? description;
  List<String> images = [];
  bool? inFavorites;
  bool? inCart;
  productModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    json['images'].forEach((element) {
      images.add(element);
    });
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
