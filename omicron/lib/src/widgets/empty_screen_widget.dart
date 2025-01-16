// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:omicron/src/common/utils/appColors.dart';
import 'package:omicron/src/widgets/app_style.dart';
import 'package:omicron/src/widgets/reusable_text.dart';

import '../const/resource.dart';

class EmptyScreenWidget extends StatelessWidget {
  const EmptyScreenWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(80),
          child: Image.asset(
            R.ASSETS_IMAGES_EMPTY_PNG,
            height: ScreenUtil().screenHeight * 0.2,
            width: ScreenUtil().screenWidth,
          ),
        ),
        ReusableText(
          text: "The Container is Empty",
          style: appStyle(18, AppColors.appDark, FontWeight.w500),
        ),
      ],
    );
  }
}
