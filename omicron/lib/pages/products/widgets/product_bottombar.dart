import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:omicron/src/common/utils/appColors.dart';
import 'package:omicron/src/widgets/app_style.dart';
import 'package:omicron/src/widgets/reusable_text.dart';

class ProductBottomBar extends StatelessWidget {
  const ProductBottomBar({super.key, required this.price, this.onPressed});

  final String price;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    //This handles the bottom bar of the product page where the total price and add to cart button is displayed
    return Container(
      height: 68.h,
      color: Colors.white.withOpacity(0.8),
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.w, 0, 5.w, 0.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Dollar Icon
            Padding(
              padding: EdgeInsets.only(left: 12.w),
              child: const Icon(
                FontAwesome.dollar,
                color: AppColors.appDark,
                size: 20,
              ),
            ),

            //Total Price is displayed here
            Container(
              padding: EdgeInsets.only(top: 10.h),
              height: 80.h,
              width: 120.w,
              child: Column(
                children: [
                  ReusableText(
                    text: "Total Price",
                    style: appStyle(13, AppColors.appDark, FontWeight.w500),
                  ),
                  ReusableText(
                    text: "\$ $price",
                    style: appStyle(16, AppColors.appDark, FontWeight.w500),
                  ),
                ],
              ),
            ),
            //Space between Total Price and Add to Cart Button
            SizedBox(
              width: 120.w,
            ),

            //Add to Cart Button
            ElevatedButton(
              style: ButtonStyle(
                //set background color
                backgroundColor: WidgetStateProperty.all(AppColors.appPrimary),
              ),
              onPressed: onPressed,
              child: Row(
                children: [
                  const Icon(
                    FontAwesome.shopping_bag,
                    color: AppColors.appWhite,
                    size: 15,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  ReusableText(
                    text: "Add to Cart",
                    style: appStyle(16, AppColors.appWhite, FontWeight.w500),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
