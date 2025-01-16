import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:omicron/pages/products/controllers/color_sizes_model.notifier.dart';
import 'package:omicron/pages/products/controllers/product_notfier.dart';
import 'package:omicron/src/common/utils/appColors.dart';
import 'package:omicron/src/const/constants.dart';
import 'package:omicron/src/widgets/app_style.dart';
import 'package:provider/provider.dart';

class ColorseclectionWidget extends StatelessWidget {
  const ColorseclectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ColorSizeModelNotifier>(
        builder: (context, controller, child) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
              context.read<ProductNotfier>().product!.colors.length, (index) {
            String c = context.read<ProductNotfier>().product!.colors[index];
            return GestureDetector(
              onTap: () {
                controller.setColors(c);
              },
              child: Container(
                height: 25.h,
                width: 60.w,
                decoration: BoxDecoration(
                  color: controller.colors == c
                      ? AppColors.appPrimary
                      : AppColors.appGrayLight,
                  borderRadius: appRadiusAll,
                ),
                child: Center(
                  child: Text(
                    c,
                    style: appStyle(15, AppColors.appOffWhite, FontWeight.bold),
                  ),
                ),
              ),
            );
          }),
        ),
      );
    });
  }
}
