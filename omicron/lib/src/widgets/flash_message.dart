import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:omicron/src/common/utils/appColors.dart';
import 'package:omicron/src/widgets/app_style.dart';
import 'package:omicron/src/widgets/reusable_text.dart';

enum MessageType { success, error }

class FlashMessageScreen extends StatelessWidget {
  final String text;
  final MessageType messgaeType;
  final VoidCallback onClose;

  const FlashMessageScreen(
      {super.key,
      required this.text,
      required this.messgaeType,
      required this.onClose});

  @override
  Widget build(BuildContext context) {
    Color background;
    String iconPath;
    String title;

    switch (messgaeType) {
      case MessageType.success:
        background = const Color.fromARGB(255, 37, 219, 113);
        iconPath = "assets/icons/success.svg";
        title = "Yee. Congrats!";
        break;
      case MessageType.error:
        background = const Color.fromARGB(255, 202, 53, 43);
        iconPath = "assets/icons/close.svg";
        title = "Snap! Error";
        break;
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          // height: height,
          height: 70,
          decoration: BoxDecoration(
            color: background,
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
          ),
        ),
        Row(
          children: [
            const SizedBox(width: 48),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 2.h),
                    child: ReusableText(
                      text: title,
                      style: appStyle(18, AppColors.appWhite, FontWeight.w500),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  ReusableText(
                    text: text,
                    style: appStyle(13, AppColors.appWhite, FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),

        //Bubbles
        Positioned(
          bottom: 0,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
            ),
            child: Stack(
              children: [
                SvgPicture.asset(
                  "assets/icons/bubble.svg",
                  height: 48,
                  width: 40,
                )
              ],
            ),
          ),
        ),

        Positioned(
            top: -15,
            left: 10,
            child: GestureDetector(
              onTap: onClose,
              child: SvgPicture.asset(iconPath, height: 35),
            ))
      ],
    );
  }
}
