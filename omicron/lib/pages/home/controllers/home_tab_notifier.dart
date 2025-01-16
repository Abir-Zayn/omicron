import 'package:flutter/material.dart';
import 'package:omicron/src/common/utils/enums.dart';

class HomeTabNotifier with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  void Function()? refetch;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  QueryType queryType = QueryType.all;
  String _index = 'All';

  String get index => _index;

  void setRefetch(Function() r) {
    refetch = r;
  }

  Future<void> fetchDataForTab(int index) async {
    _setLoadingState(true);
    try {
      // Simulate network request
      await Future.delayed(const Duration(milliseconds: 300));
    } catch (e) {
      _setErrorMessage(e.toString());
    } finally {
      _setLoadingState(false);
    }
  }

  void setIndex(String temp) {
    _index = temp;
    _updateQueryTypeAndRefetch();
    notifyListeners();
  }

  void _updateQueryTypeAndRefetch() {
    switch (_index) {
      case 'All':
        _setQueryType(QueryType.all);
        break;
      case 'Popular':
        _setQueryType(QueryType.popular);
        break;
      case 'Deals':
        _setQueryType(QueryType.deals);
        break;
      case 'Men':
        _setQueryType(QueryType.men);
        break;
      case 'Women':
        _setQueryType(QueryType.women);
        break;
      case 'Kids':
        _setQueryType(QueryType.kids);
        break;
      default:
        _setQueryType(QueryType.all);
    }
    refetch?.call();
  }

  void _setQueryType(QueryType type) {
    queryType = type;
    notifyListeners();
  }

  void _setLoadingState(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  void _setErrorMessage(String? errorMessage) {
    _errorMessage = errorMessage;
    notifyListeners();
  }
}
