import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:omicron/pages/home/widgets/notification_widget.dart';
import 'package:omicron/src/common/utils/appColors.dart';
import 'package:omicron/src/common/utils/app_strings.dart';
import 'package:omicron/src/widgets/app_style.dart';
import 'package:omicron/src/widgets/reusable_text.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

//Overview:
//CustomAppBar is a StatelessWidget.CustomAppBar is a custom app bar widget that displays the location of the user.
//CustomAppBar has an action that displays the NotificationWidget.

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: ReusableText(
                text: "Location",
                style: appStyle(14, AppColors.appGrayDark, FontWeight.w400)),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Icon(Ionicons.location_outline,
                  size: 16, color: AppColors.appGrayDark),
              SizedBox(
                width: ScreenUtil().screenWidth * 0.7,
                child: Text(
                  AppStrings.appSelectYourLocation,
                  style: appStyle(16, AppColors.appGrayDark, FontWeight.w400),
                ),
              ),
            ],
          )
        ],
      ),

      //NotificationWidget is a widget that handles the notification from backend 
      //and displays the total number of notifications.
      actions: const [
        NotificationWidget(),
      ],

      //Search Bar Box 
      bottom: PreferredSize(
          preferredSize: Size.fromHeight(55.h),
          child: GestureDetector(
            onTap: () {
              //Navigate to the Search Screen
              context.push('/search');
            },

            //Placement and UI design of the Search bar box
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //UI Design of the Search Bar
                  Container(
                    height: 40.h,
                    width: ScreenUtil().screenWidth - 80,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: AppColors.appGrayDark, width: 0.5),
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          //Searching Icons and Text
                          const Icon(
                            Ionicons.search,
                            color: AppColors.appGrayDark,
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          ReusableText(
                            text: "Seach Products",
                            style: appStyle(
                                15, AppColors.appGrayDark, FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 3.w),
                    child: Container(
                        height: 40.h,
                        width: ScreenUtil().screenWidth - 400,
                        decoration: BoxDecoration(
                            color: AppColors.appDark,
                            borderRadius: BorderRadius.circular(12)),
                        child: const Icon(
                          FontAwesome.sliders,
                          color: AppColors.appWhite,
                          size: 20,
                        )),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
