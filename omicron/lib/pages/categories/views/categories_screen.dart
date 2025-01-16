import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:omicron/pages/categories/controllers/category_notifier.dart';
import 'package:omicron/pages/categories/hook/fetch_categories.dart';
// import 'package:omicron/pages/categories/hook/fetch_products_by_category.dart';
import 'package:omicron/src/common/utils/appColors.dart';
import 'package:omicron/src/common/utils/app_strings.dart';
// import 'package:omicron/src/const/constants.dart';
import 'package:omicron/src/widgets/app_style.dart';
import 'package:omicron/src/widgets/back_button.dart';
import 'package:omicron/src/widgets/reusable_text.dart';
import 'package:omicron/src/widgets/shimmers/list_shimmer.dart';

import 'package:provider/provider.dart';

class CategoriesScreen extends HookWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final results = fetchCategoriesScreen();
    final categories = results.brand;
    final isLoading = results.isLoading;
    // final error = results.error;

    if (isLoading) {
      return const Scaffold(
        body: ListShimmer(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: ReusableText(
          text: AppStrings.appCategories,
          style: appStyle(20, AppColors.appDark, FontWeight.w500),
        ),
      ),
      body: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return ListTile(
              onTap: () {
                //Go to Category page
                context
                    .read<CategoryNotifier>()
                    .setCategory(category.title, category.id);

                context.push('/category');
              },

              //UI of the circular avatar containing the icons from the dart data model
              leading: CircleAvatar(
                backgroundColor: AppColors.appPrimary.withOpacity(0.2),
                radius: 19,
                child: Padding(
                  padding: EdgeInsets.all(8.h),
                  child: SvgPicture.network(category.imageUrl),
                ),
              ),
              title: ReusableText(
                text: category.title,
                style: appStyle(16, AppColors.appDark, FontWeight.w400),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 12,
              ),
            );
          }),
    );
  }
}
