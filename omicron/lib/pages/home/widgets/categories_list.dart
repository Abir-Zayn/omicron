import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:omicron/pages/categories/controllers/category_notifier.dart';
import 'package:omicron/pages/categories/hook/fetch_home_categories.dart';
// import 'package:omicron/pages/categories/hook/fetch_products_by_category.dart';
import 'package:omicron/src/common/utils/appColors.dart';
import 'package:omicron/src/widgets/app_style.dart';
import 'package:omicron/src/widgets/reusable_text.dart';
import 'package:omicron/src/widgets/shimmers/categories_shimmer.dart';
import 'package:provider/provider.dart';
// import '../../../src/const/constants.dart';
//import 'package:omicron/src/widgets/shimmers/list_shimmer.dart';

class HomeCategoriesList extends HookWidget {
  const HomeCategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    final results = fetchHomeCategories();
    final categories = results.brand;
    final isLoading = results.isLoading;
    // final error = results.error;

    if (isLoading) {
      const CatergoriesShimmer();
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: SizedBox(
        height: 80.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            categories.length,
            (index) {
              final category = categories[index];
              return GestureDetector(
                onTap: () {
                  //Go to Category page
                  context
                      .read<CategoryNotifier>()
                      .setCategory(category.title, category.id);
                  context.push('/category');
                },
                child: SizedBox(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.appPrimary.withOpacity(0.2),
                      child: Padding(
                          padding: EdgeInsets.all(4.h),
                          child: SvgPicture.network(
                            category.imageUrl,
                            width: 40.w,
                            height: 40.h,
                          )),
                    ),
                    ReusableText(
                        text: category.title,
                        style: appStyle(12, AppColors.appDark, FontWeight.w500))
                  ],
                )),
              );
            },
          ),
        ),
      ),
    );
  }
}
