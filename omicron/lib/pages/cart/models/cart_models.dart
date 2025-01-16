// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

List<CartModel> cartModelFromJson(String str) =>
    List<CartModel>.from(json.decode(str).map((x) => CartModel.fromJson(x)));

String cartModelToJson(List<CartModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CartModel {
  int id;
  Product product;
  int quantity;
  List<String> size;
  List<String> color;

  CartModel({
    required this.id,
    required this.product,
    required this.quantity,
    required this.size,
    required this.color,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json["id"],
        product: Product.fromJson(json["product"]),
        quantity: json["quantity"],
        size: List<String>.from(json["size"].map((x) => x)),
        color: List<String>.from(json["color"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product": product.toJson(),
        "quantity": quantity,
        "size": List<dynamic>.from(size.map((x) => x)),
        "color": List<dynamic>.from(color.map((x) => x)),
      };
}

class Product {
  int id;
  String title;
  String description;
  String price;
  bool isFeatured;
  String rating;
  String discount;
  int stock;
  String itemType;
  List<String> colors;
  List<String> imageUrls;
  List<String> sizes;
  DateTime createdAt;
  int category;
  int brand;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.isFeatured,
    required this.rating,
    required this.discount,
    required this.stock,
    required this.itemType,
    required this.colors,
    required this.imageUrls,
    required this.sizes,
    required this.createdAt,
    required this.category,
    required this.brand,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        price: json["price"],
        isFeatured: json["isFeatured"],
        rating: json["rating"],
        discount: json["discount"],
        stock: json["stock"],
        itemType: json["itemType"],
        colors: List<String>.from(json["colors"].map((x) => x)),
        imageUrls: List<String>.from(json["imageURLS"].map((x) => x)),
        sizes: List<String>.from(json["sizes"].map((x) => x)),
        createdAt: DateTime.parse(json["created_at"]),
        category: json["category"],
        brand: json["brand"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "price": price,
        "isFeatured": isFeatured,
        "rating": rating,
        "discount": discount,
        "stock": stock,
        "itemType": itemType,
        "colors": List<dynamic>.from(colors.map((x) => x)),
        "imageURLS": List<dynamic>.from(imageUrls.map((x) => x)),
        "sizes": List<dynamic>.from(sizes.map((x) => x)),
        "created_at": createdAt.toIso8601String(),
        "category": category,
        "brand": brand,
      };
}
