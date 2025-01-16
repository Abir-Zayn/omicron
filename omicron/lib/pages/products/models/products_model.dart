import 'dart:convert';

List<Products> productsFromJson(String str) =>
    List<Products>.from(json.decode(str).map((x) => Products.fromJson(x)));

String productsToJson(List<Products> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Products {
  final int id;
  final String title;
  final double price;
  final String description;
  final bool isFeatured;
  final String itemType;
  final double rating;
  final List<String> colors;
  final List<String> imageUrls;
  final List<String> sizes;
  final DateTime createdAt;
  final int category;
  final int brand;
  final int stock;
  final double discount;

  Products({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.isFeatured,
    required this.itemType,
    required this.rating,
    required this.colors,
    required this.imageUrls,
    required this.sizes,
    required this.createdAt,
    required this.category,
    required this.brand,
    required this.stock,
    required this.discount,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        id: json["id"],
        title: json["title"],
        price: double.parse(json["price"]),
        description: json["description"],
        isFeatured: json["isFeatured"] ?? false, // Provide a default value
        itemType: json["itemType"],
        rating: json["rating"] != null
            ? double.parse(json["rating"])
            : 0.0, // Handle null rating
        colors: json["colors"] != null
            ? List<String>.from(json["colors"].map((x) => x))
            : [], // Handle null colors
        imageUrls: json["imageURLS"] != null
            ? List<String>.from(json["imageURLS"].map((x) => x))
            : [], // Handle null imageURLs
        sizes: json["sizes"] != null
            ? List<String>.from(json["sizes"].map((x) => x))
            : [], // Handle null sizes
        createdAt: DateTime.parse(json["created_at"]),
        category: json["category"],
        brand: json["brand"],
        stock: json["stock"],
        discount:
            json["discount"] != null ? double.parse(json["discount"]) : 0.0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "is_featured": isFeatured,
        "itemType": itemType,
        "ratings": rating,
        "colors": List<dynamic>.from(colors.map((x) => x)),
        "imageUrls": List<dynamic>.from(imageUrls.map((x) => x)),
        "sizes": List<dynamic>.from(sizes.map((x) => x)),
        "created_at": createdAt.toIso8601String(),
        "category": category,
        "brand": brand,
        "stock": stock,
        "discount": discount,
      };
}
