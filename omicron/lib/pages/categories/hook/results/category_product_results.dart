import 'package:flutter/material.dart';
import 'package:omicron/pages/products/models/products_model.dart';

// FetchCategories class
class FetchProducts{
  final List<Products> products;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;

// FetchCategories constructor
  FetchProducts({
    required this.products,
    required this.isLoading,
    required this.error,
    required this.refetch,
  });

}