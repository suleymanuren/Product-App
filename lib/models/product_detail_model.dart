class ProductDetailModel {
  Product? product;

  ProductDetailModel({this.product});

  ProductDetailModel.fromJson(Map<String, dynamic> json) {
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
    List<Likes>? likes;

}

class Product {
  int? id;
  String? name;
  int? price;
  String? image;
  String? description;
  String? timeStamp;
  List<Likes>? likes;

  Product(
      {this.id,
      this.name,
      this.price,
      this.image,
      this.description,
      this.timeStamp,
      this.likes});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    image = json['image'];
    description = json['description'];
    timeStamp = json['timeStamp'];
    if (json['likes'] != null) {
      likes = <Likes>[];
      json['likes'].forEach((v) {
        likes!.add(new Likes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['image'] = this.image;
    data['description'] = this.description;
    data['timeStamp'] = this.timeStamp;
    if (this.likes != null) {
      data['likes'] = this.likes!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  map(Likes Function(dynamic item) param0) {}
}

class Likes {
  int? id;
  String? email;
  String? password;
  String? name;
  String? token;
  int? timeStamp;

  Likes(
      {this.id,
      this.email,
      this.password,
      this.name,
      this.token,
      this.timeStamp});

  Likes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    password = json['password'];
    name = json['name'];
    token = json['token'];
    timeStamp = json['timeStamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['password'] = this.password;
    data['name'] = this.name;
    data['token'] = this.token;
    data['timeStamp'] = this.timeStamp;
    return data;
  }
}