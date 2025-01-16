import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:omicron/pages/categories/hook/results/category_product_results.dart';
import 'package:omicron/pages/products/models/products_model.dart';
import 'package:omicron/src/common/utils/enums.dart';
import 'package:omicron/src/common/utils/environment.dart';
import 'package:http/http.dart' as http;

FetchProducts fetchproducts(QueryType queryType) {
  final products = useState<List<Products>>([]);
  final isLoading = useState(false);
  final error = useState<String?>(null);

  //fetch the data
  Future<void> fetchData() async {
    isLoading.value = true;
    error.value = null;
    Uri url;

    try {
      switch (queryType) {
        case QueryType.all:
          url = Uri.parse('${Environment.baseUrl}/api/product');
          break;

        case QueryType.deals:
          url = Uri.parse('${Environment.baseUrl}/api/product/brands/deals');
          break;

        case QueryType.popular:
          url = Uri.parse("${Environment.baseUrl}/api/product/popular");
          break;

        case QueryType.men:
          url = Uri.parse(
              "${Environment.baseUrl}/api/product/byType?itemtype=${queryType.name}");
          break;

        case QueryType.women:
          url = Uri.parse(
              "${Environment.baseUrl}/api/product/byType?itemtype=${queryType.name}");
          break;

        case QueryType.kids:
          url = Uri.parse(
              "${Environment.baseUrl}/api/product/byType?itemtype=${queryType.name}");
          break;
      }
      final response = await http.get(url);
      if (response.statusCode == 200) {
        products.value = productsFromJson(response.body);
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
    products: products.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
