import 'package:flutter/material.dart';
import 'package:omicron/pages/cart/models/cart_models.dart';

class FetchCart {
  final List<CartModel> cart;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;

  FetchCart({
    required this.cart,
    required this.isLoading,
    this.error,
    required this.refetch,
  });
}
