import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omicron/src/common/utils/appColors.dart';
import 'package:omicron/src/common/utils/app_strings.dart';
import 'package:omicron/src/const/resource.dart';

class OnboardingPageTwo extends StatelessWidget {
  const OnboardingPageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenUtil().screenWidth,
      height: ScreenUtil().screenHeight,
      child: Stack(
        children: [
              SizedBox(
                height: ScreenUtil().screenHeight *0.8,
                width: ScreenUtil().screenWidth,
                child: Image.asset(
                R.ASSETS_IMAGES_WISHLIST_PNG,
                fit: BoxFit.contain,
                ),
              ),
          
          Positioned(
              bottom: 170,
              left: 30,
              right: 30,
              child: Text(
                AppStrings.appOnboardWishListMessage,
                textAlign: TextAlign.center,
                style: GoogleFonts.afacad(
                  color: AppColors.appGray,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                ),
              ))
        ],
      ),
    );
  }
}
