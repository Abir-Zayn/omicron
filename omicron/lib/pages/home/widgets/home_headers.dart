import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:omicron/src/common/utils/appColors.dart';
import 'package:omicron/src/common/utils/app_strings.dart';
import 'package:omicron/src/widgets/app_style.dart';
import 'package:omicron/src/widgets/reusable_text.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ReusableText(
          text: AppStrings.appCategories,
          style: appStyle(13, AppColors.appDark, FontWeight.w500),
        ),
        // This deals with the navigation to the all categories page
        GestureDetector(
          onTap: () {
            context.push('/categories');
          },
          child: ReusableText(
            text: AppStrings.appViewAll,
            style: appStyle(14, AppColors.appDark, FontWeight.w300),
          ),
        )
      ],
    );
  }
}
