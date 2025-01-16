import 'package:http/http.dart' as http;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:omicron/pages/cart/hooks/results/cart_results.dart';
import 'package:omicron/pages/cart/models/cart_models.dart';
import 'package:omicron/src/common/services/storage.dart';
import 'package:omicron/src/common/utils/environment.dart';

FetchCart fetchCart() {
  final cart = useState<List<CartModel>>([]);
  final isLoading = useState(false);
  final error = useState<String?>(null);
  String? accessToken = Storage().getString('accessToken');

  //fetch the data
  Future<void> fetchData() async {
    isLoading.value = true;
    error.value = null;

    try {
      final url = Uri.parse('${Environment.baseUrl}/api/cart/me/');

      final response = await http.get(
        url,
        headers: {
          "Authorization": "Token $accessToken",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        try {
          cart.value = cartModelFromJson(response.body);
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

  return FetchCart(
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
    cart: cart.value,
  );
}
