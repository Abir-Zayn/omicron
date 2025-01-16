import 'dart:convert';

CreatecartModel createCartModelFromJson(String str) =>
    CreatecartModel.fromJson(json.decode(str));
String createCartModelToJson(CreatecartModel data) =>
    json.encode(data.toJson());

class CreatecartModel {
  final int product;
  final int quantity;
  final List<String> size;
  final List<String> color;
  
  CreatecartModel({
    required this.product,
    this.quantity =1,
    required this.size,
    required this.color,
  });

  factory CreatecartModel.fromJson(Map<String, dynamic> json) =>
      CreatecartModel(
        product: json["product"],
        quantity: json["quantity"],
        size: json["size"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "product": product,
        "quantity": quantity,
        "size": size,
        "color": color,
      };
}
