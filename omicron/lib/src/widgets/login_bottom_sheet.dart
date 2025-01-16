import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:omicron/src/const/constants.dart';
import 'package:omicron/src/widgets/reusable_text.dart';
import '../common/utils/appColors.dart';
import '../common/utils/app_strings.dart';
import 'app_style.dart';
import 'custom_button.dart';

Future<dynamic> loginBottomSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 200,
        decoration: BoxDecoration(borderRadius: appRadiusTop),
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            SizedBox(
              height: 10.h,
            ),
            Center(
                child: ReusableText(
                    text: AppStrings.appLogin,
                    style:
                        appStyle(16, AppColors.appPrimary, FontWeight.w500))),
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
            Center(
                child: ReusableText(
                    text: AppStrings.appLoginText,
                    style:
                        appStyle(14, AppColors.appGrayDark, FontWeight.w500))),
            SizedBox(
              height: 20.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Padding(
                padding: const EdgeInsets.all( 8.0),
                child: GradientBtn(
                  btnColor: AppColors.appPrimary,
                  text: "Proceed to Login",
                  onTap: () {
                    context.go("/login");
                  },
                  btnHieght: 35.h,
                  radius: 16,
                  btnWidth: ScreenUtil().screenWidth,
                ),
              ),
            )
          ],
        ),
      );
    },
  );
}
