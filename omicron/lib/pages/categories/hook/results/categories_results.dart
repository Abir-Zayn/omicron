import 'package:flutter/material.dart';
import 'package:omicron/pages/categories/models/catrgories_model.dart';

// FetchCategories class
class FetchCategories{
  final List<Categories> brand;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;

// FetchCategories constructor
  FetchCategories({
    required this.brand,
    required this.isLoading,
    required this.error,
    required this.refetch,
  });

}