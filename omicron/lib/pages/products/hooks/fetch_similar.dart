import 'package:http/http.dart' as http;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:omicron/pages/categories/hook/results/category_product_results.dart';
import 'package:omicron/pages/products/models/products_model.dart';
import 'package:omicron/src/common/utils/environment.dart';

FetchProducts fetchSimilarProducts(int categoryID) {
  final products = useState<List<Products>>([]);
  final isLoading = useState(false);
  final error = useState<String?>(null);

  //fetch the data
  Future<void> fetchData() async {
    isLoading.value = true;
    error.value = null;

    try {
      final url = Uri.parse(
          '${Environment.baseUrl}/api/product/recommended?brand=$categoryID'); //${Environment.baseUrl} 'http://127.0.0.1:8000/api/product/brands/home'
      final response = await http.get(url);

      if (response.statusCode == 200) {
        try {
          products.value = productsFromJson(response.body);
        } catch (e) {
          error.value = 'Failed to parse response data: $e';
          print('JSON parsing error: $e');
          print('Response body: ${response.body}');
        }
      } else {
        error.value = 'Server returned status code: ${response.statusCode}';
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
    // isLoading.value = true;
    fetchData();
  }

  return FetchProducts(
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
    products: products.value,
  );
}
