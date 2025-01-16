import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:omicron/src/common/services/storage.dart';
import 'package:omicron/src/common/utils/environment.dart';

class WishlistNotifier extends ChangeNotifier {
  String? error = '';
  Set<int> wishListedProduct = {};

  void setError(String e) {
    error = e;
    notifyListeners();
  }

  bool isProductWishListed(int productId) {
    return wishListedProduct.contains(productId);
  }

  Future<void> addRemoveWishList(int productId, VoidCallback refetch) async {
    await toggleWishlist(productId);
    if (wishListedProduct.contains(productId)) {
      wishListedProduct.remove(productId);
    } else {
      wishListedProduct.add(productId);
    }
    notifyListeners();
    refetch(); // Refresh the wishlist after toggling
  }

  Future<void> toggleWishlist(int productId) async {
    try {
      final url = Uri.parse('${Environment.baseUrl}/api/wishlist/toggle/');
      String? accessToken = Storage().getString('accessToken');

      final response = await http.post(
        url,
        headers: {
          "Authorization": "Token $accessToken",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "id": productId,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Success
        print('Wishlist toggled successfully');
      } else {
        print('Failed to toggle wishlist: ${response.statusCode}');
      }
    } catch (e) {
      print('Error toggling wishlist: $e');
    }
  }
}
