import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:omicron/src/common/utils/app_strings.dart';
import 'package:omicron/src/widgets/reusable_text.dart';
// import 'package:provider/provider.dart';

import '../common/services/storage.dart';
import '../common/utils/appColors.dart';
import '../const/constants.dart';
import 'app_style.dart';
import 'custom_button.dart';

Future<dynamic> logoutBottomSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 200,
        decoration: BoxDecoration(borderRadius: appRadiusTop),
        child: ListView(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Center(
                child: ReusableText(
                    text: AppStrings.appLogout,
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
                    text: AppStrings.appLogoutText,
                    style: appStyle(14, AppColors.appGray, FontWeight.w500))),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GradientBtn(
                    text: "Cancel",
                    borderColor: AppColors.appDark,
                    btnColor: AppColors.appWhite,
                    onTap: () => Navigator.pop(context),
                    btnHieght: 35.h,
                    radius: 16,
                    btnWidth: ScreenUtil().screenWidth / 2.2,
                  ),
                  GradientBtn(
                    text: "Yes, Logout",
                    onTap: () {
                      Storage().removeKey('accessToken');
                      // context.read<TabIndexNotifier>().tabIndex = 0;
                      context.go("/home");
                      context.pop();
                    },
                    btnHieght: 35.h,
                    radius: 16,
                    btnWidth: ScreenUtil().screenWidth / 2.2,
                  ),
                ],
              ),
            )
          ],
        ),
      );
    },
  );
}
