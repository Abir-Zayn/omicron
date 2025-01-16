import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:omicron/pages/products/controllers/color_sizes_model.notifier.dart';
import 'package:omicron/pages/products/controllers/product_notfier.dart';
import 'package:omicron/src/common/utils/appColors.dart';
import 'package:omicron/src/widgets/app_style.dart';
import 'package:provider/provider.dart';

class ProductSizesWidget extends StatelessWidget {
  const ProductSizesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ColorSizeModelNotifier>(
        builder: (context, controller, child) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
              context.read<ProductNotfier>().product!.sizes.length, (index) {
            String s = context.read<ProductNotfier>().product!.sizes[index];
            return GestureDetector(
              onTap: () {
                controller.setSize(s);
              },
              child: Container(
                height: 30.h,
                width: 45.w,
                decoration: BoxDecoration(
                  color: controller.size == s
                      ? AppColors.appPrimary
                      : AppColors.appGrayLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    s,
                    style: appStyle(19, AppColors.appOffWhite, FontWeight.bold),
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
