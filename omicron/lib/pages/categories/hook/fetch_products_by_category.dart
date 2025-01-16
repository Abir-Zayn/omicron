import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:omicron/pages/categories/hook/results/category_product_results.dart';
import 'package:omicron/pages/products/models/products_model.dart';
import 'package:omicron/src/common/utils/environment.dart';

// purpose ; Filtering the products based on the brands

FetchProducts fetchProductsViaBrand(int brandID) {
  final products = useState<List<Products>>([]);
  final isLoading = useState(false);
  final error = useState<String?>(null);

  //fetch the data
  Future<void> fetchData() async {
    isLoading.value = true;
    error.value = null;

    try {
      final url = Uri.parse(
          '${Environment.baseUrl}/api/product/filter-by-brand/?brand=$brandID'); //
      final response = await http.get(url);

      if (response.statusCode == 200) {
        try {
          //Parse the complete response first
          final Map<String, dynamic> responseData = json.decode(response.body);

          // Extract the products array from the response
          final List<dynamic> productsData = responseData['products'];
          
          // Convert the products array to a list of products 
          products.value= productsData
              .map((product) => Products.fromJson(product))
              .toList();

        } catch (e) {
          error.value = "Failed to parse response Data: $e";
          print(error.value);
          print('Response body: ${response.body}');
        }
      }else{
        error.value = "Server returned status code ${response.statusCode}";
         print('Server error: ${response.body}');
      }
    } catch (e) {
      error.value = 'Network error: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  useEffect(() {
    fetchData();
    return null;
  }, const []);

  void refetch() {
    isLoading.value = true;

    fetchData();
  }

  return FetchProducts(
    products: products.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
