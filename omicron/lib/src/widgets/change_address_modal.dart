import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:omicron/src/common/utils/app_strings.dart';
import 'package:omicron/src/widgets/reusable_text.dart';

import '../common/utils/appColors.dart';
import '../const/constants.dart';
import 'app_style.dart';

Future<dynamic> changeAddressBottomSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: ScreenUtil().screenHeight,
        decoration: BoxDecoration(borderRadius: appRadiusTop),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          physics: const NeverScrollableScrollPhysics(),
          children: [
            SizedBox(
              height: 10.h,
            ),
            Center(
                child: ReusableText(
                    text: AppStrings.appCheckoutAddress,
                    style: appStyle(16, AppColors.appPrimary, FontWeight.w500))),
            SizedBox(
              height: 10.h,
            ),
            Divider(
              color: AppColors.appGrayLight,
              thickness: 0.5.h,
            ),
            SizedBox(
              height: 10.h,
            ),
            ReusableText(
                text: AppStrings.appCheckoutAddressText,
                style: appStyle(13, AppColors.appGray, FontWeight.w500)),
            SizedBox(
              height: 10.h,
            ),

            //TODO Add CheckoutAddressSelection

            SizedBox(
              height: ScreenUtil().screenHeight*0.6,
              // child: const CheckoutAddressSelection()
            )
          ],
        ),
      );
    },
  );
}
