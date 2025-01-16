import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:omicron/src/common/utils/appColors.dart';
import 'package:omicron/src/common/utils/app_strings.dart';
import 'package:omicron/src/widgets/app_style.dart';
import 'package:omicron/src/widgets/back_button.dart';
import 'package:omicron/src/widgets/reusable_text.dart';

class PolicyScreen extends StatefulWidget {
  const PolicyScreen({super.key});

  @override
  State<PolicyScreen> createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen>
    with SingleTickerProviderStateMixin {
  bool _isChecked = false;
  late AnimationController _animationController;
  late Animation<double> _animation;
  Color _checkboxColor = AppColors.appPrimary;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation =
        Tween<double>(begin: 0.0, end: 10.0).animate(_animationController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _animationController.reverse();
            }
          });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleButtonPress() {
    if (_isChecked) {
      // Navigate to home page
      context.pop();
    } else {
      setState(() {
        _checkboxColor = Colors.red;
      });
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: ReusableText(
            text: "Privacy Policy",
            style: appStyle(18, AppColors.appDark, FontWeight.bold)),
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: ListView(
            children: [
              SizedBox(
                height: 20.h,
              ),
              ReusableText(
                text: AppStrings.appCancelation,
                style: appStyle(17, AppColors.appPrimary, FontWeight.w500),
              ),
              SizedBox(
                height: 12.h,
              ),
              Text(
                AppStrings.appAppCancelationPolicy,
                textAlign: TextAlign.justify,
                style: appStyle(14, AppColors.appGray, FontWeight.normal),
              ),
              SizedBox(
                height: 12.h,
              ),
              ReusableText(
                text: AppStrings.appTerms,
                style: appStyle(17, AppColors.appPrimary, FontWeight.w500),
              ),
              SizedBox(
                height: 12.h,
              ),
              Text(
                AppStrings.appAppTerms,
                textAlign: TextAlign.justify,
                style: appStyle(14, AppColors.appGray, FontWeight.normal),
              ),
              SizedBox(
                height: 12.h,
              ),
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(_animation.value, 0),
                    child: Row(
                      children: [
                        Checkbox(
                          value: _isChecked,
                          onChanged: (value) {
                            setState(() {
                              _isChecked = value!;
                              _checkboxColor = AppColors.appPrimary;
                            });
                          },
                          activeColor: _checkboxColor,
                        ),
                        Expanded(
                          child: ReusableText(
                            text:
                                "Thereby, I have acknowledge and accpet the terms and Condition",
                            style: appStyle(
                                13, AppColors.appGray, FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              ElevatedButton(
                onPressed: _handleButtonPress,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.appPrimary,
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: ReusableText(
                  text: "Continue",
                  style: appStyle(14, AppColors.appWhite, FontWeight.w500),
                ),
              ),
              SizedBox(height: 12.h)
            ],
          )),
    );
  }
}
