import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:omicron/pages/auth/controllers/auth_notifier.dart';
import 'package:omicron/pages/auth/models/profile_model.dart';
import 'package:omicron/pages/auth/views/login_screen.dart';
import 'package:omicron/pages/profile/widget/tile_widget.dart';
import 'package:omicron/src/common/services/storage.dart';
import 'package:omicron/src/common/utils/appColors.dart';
import 'package:omicron/src/common/utils/app_strings.dart';
import 'package:omicron/src/widgets/app_style.dart';
import 'package:omicron/src/widgets/custom_button.dart';
import 'package:omicron/src/widgets/help_bottom_sheet.dart';
import 'package:omicron/src/widgets/reusable_text.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');

    if (accessToken == null) {
      return const LoginScreen();
    }

    return Scaffold(
      body: Consumer<AuthNotifier>(builder: (context, authNotifier, child) {
        ProfileModel? user = authNotifier.getUserData();

        if (user == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return SafeArea(
          child: ListView(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 30.h,
                  ),

                  //Showing Profile Image
                  const CircleAvatar(
                    radius: 35,
                    backgroundColor: AppColors.appOffWhite,
                    backgroundImage: NetworkImage(AppStrings.appProfilePic),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  ReusableText(
                      text: user.email,
                      style:
                          appStyle(14, AppColors.appGray, FontWeight.normal)),
                  SizedBox(
                    height: 5.h,
                  ),
                  ReusableText(
                      text: user.username,
                      style: appStyle(16, AppColors.appGray, FontWeight.bold)),
                  SizedBox(
                    height: 25.h,
                  ),
                ],
              ),
              Row(
                children: [
                  //This container will give user details of how many orders he has done
                  Container(
                    margin: EdgeInsets.only(left: 30.w, right: 10.w),
                    width: ScreenUtil().screenWidth * 0.4,
                    height: 80.h,
                    decoration: BoxDecoration(
                      color: AppColors.appPrimary.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ReusableText(
                            text: "Total Ordered",
                            style: appStyle(
                                14, AppColors.appDark, FontWeight.normal)),
                        SizedBox(
                          height: 5.h,
                        ),
                        ReusableText(
                            text: "10",
                            style: appStyle(
                                16, AppColors.appDark, FontWeight.bold)),
                      ],
                    ),
                  ),
                  //This container will give user details of how many reviews he has given
                  Container(
                    margin: EdgeInsets.only(left: 20.w, right: 20.w),
                    width: ScreenUtil().screenWidth * 0.4,
                    height: 80.h,
                    decoration: BoxDecoration(
                      color: AppColors.appPrimary.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ReusableText(
                            text: "Total Reviewed",
                            style: appStyle(
                                14, AppColors.appDark, FontWeight.normal)),
                        SizedBox(
                          height: 5.h,
                        ),
                        ReusableText(
                            text: "3",
                            style: appStyle(
                                16, AppColors.appDark, FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30.w),
                child: Column(
                  children: [
                    //My Orders Tile
                    TileWidget(
                        title: "My Orders",
                        leading: Octicons.checklist,
                        onTap: () {
                          context.push('/orders');
                        }),

                    //Shipping Address
                    TileWidget(
                        title: "Shipping Address",
                        leading: Octicons.location,
                        onTap: () {
                          context.push('/address');
                        }),

                    //Privacy Policy
                    TileWidget(
                        title: "Privacy Policy",
                        leading: MaterialIcons.policy,
                        onTap: () {
                          context.push('/policy');
                        }),

                    //Terms & Conditions
                    TileWidget(
                        title: "Terms & Conditions",
                        leading: MaterialIcons.description,
                        onTap: () {
                          showHelpCenterBottomSheet(context);
                        }),

                    SizedBox(
                      height: 20.h,
                    ),

                    //Sign Out Button
                    GradientBtn(
                      text: "Sign Out",
                      btnColor: AppColors.appRed,
                      btnWidth: ScreenUtil().screenWidth * 0.8,
                      onTap: () {
                        context.read<AuthNotifier>().logout(context);
                      },
                      btnHieght: 40.h,
                    )
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
