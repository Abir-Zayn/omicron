import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:omicron/src/common/services/storage.dart';

import 'package:omicron/src/common/utils/appColors.dart';
import 'package:omicron/src/widgets/login_bottom_sheet.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (Storage().getString('accessToken') == null) {
            //User is not logged in
            loginBottomSheet(context);
            // context.push('/login');
            // return;
          } else {
            //Navigate to the Notification Screen
            context.push('/notifications');
          }
        },
        child: Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: CircleAvatar(
              backgroundColor: AppColors.appGrayDark.withOpacity(0.1),
              child: const Badge(
                label: Text("4"),
                child: Icon(
                  Ionicons.notifications_outline,
                  color: AppColors.appGrayDark,
                ),
              ),
            )));
  }
}
