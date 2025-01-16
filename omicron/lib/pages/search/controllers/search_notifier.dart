import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:omicron/pages/products/models/products_model.dart';
import 'package:omicron/src/common/services/storage.dart';
import 'package:omicron/src/common/utils/environment.dart';

class SearchNotifier with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Holds the list of products matching the search query.
  List<Products> _results = [];
  List<Products> get results => _results;

  //Sets _results with the search results and notifies listeners.
  void setresults(List<Products> value) {
    _results = value;
    notifyListeners();
  }

  //Clears the search results.
  void clearResults() {
    _results = [];
    notifyListeners();
  }

  String _searchKey = '';
  String get searchKey => _searchKey;

  //Stores the current search keyword.
  //Sets _searchKey to the user’s input and updates listeners.
  void setsearchKey(String value) {
    _searchKey = value;
    notifyListeners();
  }

  //Stores the error message.
  //Sets _error to the error message and updates listeners.
  String _error = '';
  String get error => _error;

  void setError(String value) {
    _error = value;
    notifyListeners();
  }

  //Searches for products that match the search query.
  //1. Sets _isLoading to true & update the search key.
  //2. Sends a GET request to the API with the search key.
  //3. If the request is successful, it parses the response and sets the results.

  Future<void> searchFunction(String searchKey) async {
    setLoading(true);
    setsearchKey(searchKey);

    addToSearchHistory(searchKey);

    //Sends a GET request to the API with the search key.
    Uri url =
        Uri.parse('${Environment.baseUrl}/api/product/search?q=$searchKey');

    try {
      var response = await http.get(url);
      // If the request is successful, it parses the response and sets the results.
      if (response.statusCode == 200) {
        var data = productsFromJson(response.body);
        setresults(data);
        setLoading(false);
      } else {
        setError('An error occurred. Please try again later.');
      }
    } catch (e) {
      e.toString();
    } finally {
      setLoading(false);
    }
  }

  // List to store search history
  List<String> _searchHistory = [];
  List<String> get searchHistory => _searchHistory;

  void addToSearchHistory(String searchkey) async {
    if (searchkey.trim().isEmpty) return;
    //Remove the search key if it already exists
    _searchHistory.remove(searchkey);

    //Add the search key to the beginning of the list
    _searchHistory.insert(0, searchkey);

    //only show the 3 most recent searches
    if (_searchHistory.length > 3) {
      _searchHistory = _searchHistory.sublist(0, 3);
    }

    //Save to storage and notify listeners
    Storage().setStringList('searchHistory', _searchHistory);
    notifyListeners();
  }

  /// Loads the search history from storage when the notifier is initialized.
  Future<void> loadSearchHistory() async {
    try {
      final history = Storage().getStringList('searchHistory');
      if (history != null) {
        _searchHistory = List<String>.from(history);
        notifyListeners();
      }
    } catch (e) {
      setError('Failed to load search history');
    }
  }

  /// Clears the search history.
  Future<void> clearSearchHistory() async {
    _searchHistory.clear();
    await Storage().removeKey('searchHistory');
    notifyListeners();
  }
}
