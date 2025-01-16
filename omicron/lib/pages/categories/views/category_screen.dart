import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:omicron/pages/categories/controllers/category_notifier.dart';
import 'package:omicron/pages/categories/widgets/products_by_category.dart';
import 'package:omicron/src/common/utils/appColors.dart';
import 'package:omicron/src/widgets/app_style.dart';
import 'package:omicron/src/widgets/back_button.dart';
import 'package:omicron/src/widgets/reusable_text.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 120.w),
          child: ReusableText(
            text: context.read<CategoryNotifier>().category,
            style: appStyle(20, AppColors.appDark, FontWeight.w500),
          ),
        ),
      ),
      body: const ProductScreenByCategory(),
    );
  }
}

