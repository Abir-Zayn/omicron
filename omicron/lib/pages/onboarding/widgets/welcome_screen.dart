import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omicron/src/common/utils/appColors.dart';
import 'package:omicron/src/common/utils/app_strings.dart';
import 'package:omicron/src/const/resource.dart';
import 'package:omicron/src/widgets/app_style.dart';
import 'package:omicron/src/widgets/custom_button.dart';
import 'package:omicron/src/widgets/reusable_text.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.appWhite,
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenHeight,
        child: Column(
          children: [
            SizedBox(
              height: 100.h,
            ),
            Image.asset(R.ASSETS_IMAGES_GETSTARTED_PNG),
            SizedBox(
              height: 30.h,
            ),
            Text(
              AppStrings.appWelcomeHeader,
              textAlign: TextAlign.center,
              style: GoogleFonts.openSans(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              width: ScreenUtil().screenWidth - 100,
              child: Text(
                AppStrings.appWelcomeMessage,
                textAlign: TextAlign.center,
                style: appStyle(
                  15.sp,
                  AppColors.appGray,
                  FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            GradientBtn(
              text: "Get Started",
              btnHieght: 50,
              radius: 10,
              btnWidth: ScreenUtil().screenWidth - 80,
              btnColor: AppColors.appPrimary,
              onTap: () {
                // Storage().setBool('firstOpen',true);

                context.go('/home');
              },
            ),
            SizedBox(
              height: 15.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ReusableText(
                  text: "Already have an account?",
                  style: appStyle(14, Colors.black, FontWeight.w400),
                ),

                //Login Button
                TextButton(
                  onPressed: () {
                    context.go('/login');
                  },
                  child: Text(
                    "Sign In",
                    style: appStyle(15, Colors.black, FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
