class ShopLoginModel {
  late bool status;
  late String  message;
   userData? data;
  ShopLoginModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
    data=json['data'] != null ? userData.fromJson(json['data']):null;
  }
}

class userData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? cradit;
  String? token;

  userData.fromJson(Map<String,dynamic>json){
    id=json['id'];
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    image=json['image'];
    points=json['points'];
    cradit=json['cradit'];
    token=json['token'];
  }
}
