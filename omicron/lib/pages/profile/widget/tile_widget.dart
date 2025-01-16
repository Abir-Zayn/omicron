import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:omicron/src/common/utils/appColors.dart';
import 'package:omicron/src/widgets/app_style.dart';
import 'package:omicron/src/widgets/reusable_text.dart';

class TileWidget extends StatelessWidget {
  const TileWidget(
      {super.key, required this.title, this.onTap, required this.leading});

  final String title;
  final void Function()? onTap;
  final IconData leading;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10.w, 1.h, 10.w, 1.h),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.appPrimary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        visualDensity: VisualDensity.compact,
        onTap: onTap,
        leading: Icon(leading, color: AppColors.appGray),
        title: ReusableText(
            text: title,
            style: appStyle(13, AppColors.appDark, FontWeight.w400)),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 15,
        ),
      ),
    );
  }
}
