import 'dart:convert';

CartItemCount cartItemCountFromJson(String str) => CartItemCount.fromJson(json.decode(str));

String cartItemCountToJson(CartItemCount data) => json.encode(data.toJson());

class CartItemCount {
    int cartCount;

    CartItemCount({
        required this.cartCount,
    });

    factory CartItemCount.fromJson(Map<String, dynamic> json) => CartItemCount(
        cartCount: json["cart count"],
    );

    Map<String, dynamic> toJson() => {
        "cart count": cartCount,
    };
}
