import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:omicron/pages/cart/models/createCart_model.dart';
import 'package:http/http.dart' as http;
import 'package:omicron/src/common/utils/environment.dart';

class CartNotifier with ChangeNotifier {
  final Map<int, int> _quantities = {};
  Map<int, int> get quantities => _quantities;

  // final List<Products> _cartItems = [];
  // List<Products> get cartItems => _cartItems;

  //. The increment function increases the quantity of the specified item and then notifies any listeners about the change.
//   _quantities[cartID] ?? 1: This part checks if there is already a quantity set for the given cartID in the _quantities map.
// If _quantities[cartID] is null (i.e., the item is not yet in the cart), it uses 1 as the default value.
// (_quantities[cartID] ?? 1) + 1: It then adds 1 to this value, effectively incrementing the quantity by 1.
  void increment(int cartID) {
    _quantities[cartID] = (_quantities[cartID] ?? 1) + 1;
    notifyListeners();
  }

  void decrement(int cartId) {
    if ((_quantities[cartId] ?? 1) > 1) {
      _quantities[cartId] = (_quantities[cartId]! - 1);
      notifyListeners();
    }
  }

  void initializeQuantity(int cartId, int initialQuantity) {
    if (!_quantities.containsKey(cartId)) {
      _quantities[cartId] = initialQuantity;
      notifyListeners();
    }
  }

  Future<void> updateCart(
      int id, String accessToken, void Function() refetch) async {
    try {
      Uri url = Uri.parse(
          '${Environment.baseUrl}/api/cart/update/?id=$id&count=${_quantities[id]}');

      final response = await http.patch(
        url,
        headers: {
          'Authorization': 'Token $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        refetch();
      } else {
        debugPrint('Error: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future<void> deleteCart(
      int id, String accessToken, void Function() refetch) async {
    try {
      Uri url = Uri.parse(
          '${Environment.baseUrl}/api/cart/remove/?id=$id'); // Note the added '?' and 'id='

      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Token $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 204) {
        // Changed to 204 as per your backend
        _quantities.remove(id);
        refetch();
        notifyListeners();
      } else {
        debugPrint('Error: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  // Future<void> deleteAllCart(
  //     String accessToken, void Function() refetch) async {
  //   try {
  //     Uri url = Uri.parse('${Environment.baseUrl}/api/cart/delete-all');

  //     final response = await http.delete(
  //       url,
  //       headers: {
  //         'Authorization': 'Token $accessToken',
  //         'Content-Type': 'application/json',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       _quantities.clear();
  //       refetch();
  //       notifyListeners();
  //     } else {
  //       debugPrint('Error: ${response.body}');
  //     }
  //   } catch (e) {
  //     debugPrint('Error: $e');
  //   }
  // }

  Future<void> addToCart(CreatecartModel cartData, String accessToken,
      void Function() refetch) async {
    try {
      Uri url = Uri.parse('${Environment.baseUrl}/api/cart/add/');

      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Token $accessToken',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(cartData.toJson()),
      );

      print('Cart Addition Response Status: ${response.statusCode}');
      print('Cart Addition Response Body: ${response.body}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        debugPrint('Cart item added successfully');
        refetch();
      } else {
        // More detailed error logging
        debugPrint('Error adding to cart: ${response.statusCode}');
        debugPrint('Response body: ${response.body}');

        throw Exception('Failed to add item to cart');
      }
    } catch (e) {
      debugPrint('Exception in addToCart: $e');
      rethrow;
    }
  }
}
