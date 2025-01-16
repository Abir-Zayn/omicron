import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:omicron/pages/auth/controllers/auth_notifier.dart';
import 'package:omicron/pages/auth/models/login_model.dart';
import 'package:omicron/src/common/utils/appColors.dart';
import 'package:omicron/src/widgets/app_style.dart';
import 'package:omicron/src/widgets/back_button.dart';
import 'package:omicron/src/widgets/custom_button.dart';
import 'package:omicron/src/widgets/email_textfield.dart';
import 'package:omicron/src/widgets/password_field.dart';
import 'package:omicron/src/widgets/reusable_text.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _usernameController =
      TextEditingController();
  late final TextEditingController _passwordController =
      TextEditingController();
  final FocusNode _passwordNode = FocusNode();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _passwordNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appWhite,
      appBar: AppBar(
        leading: const AppBackButton(),
      ),
      body: ListView(
        children: [
          SizedBox(height: 120.h),
          Text(
            "O M I C R O N",
            textAlign: TextAlign.center,
            style: appStyle(24, AppColors.appDark, FontWeight.w700),
          ),
          SizedBox(height: 12.h),
          Text(
            "Hello there! Where have you been? \n You're missed.Continue Now?",
            textAlign: TextAlign.center,
            style: appStyle(14, AppColors.appGray, FontWeight.w400),
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                EmailTextField(
                  radius: 20,
                  focusNode: _passwordNode,
                  hintText: "Enter Username",
                  controller: _usernameController,
                  prefixIcon: const Icon(CupertinoIcons.mail_solid,
                      size: 18, color: AppColors.appGray),
                  keyboardType: TextInputType.emailAddress,
                  // textInputAction: TextInputAction.next,
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(_passwordNode);
                  },
                ),
                SizedBox(height: 20.h),
                PasswordField(
                    hint: "Password",
                    controller: _passwordController,
                    focusNode: _passwordNode,
                    radius: 20),
                SizedBox(height: 20.h),

                //Check if its loading, show the loading indicator
                context.watch<AuthNotifier>().isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          backgroundColor: AppColors.appPrimary,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(AppColors.appDark),
                        ),
                      )
                    : GradientBtn(
                        text: "Login",
                        btnHieght: 45,
                        radius: 20,
                        btnWidth: ScreenUtil().screenWidth - 80,
                        btnColor: AppColors.appPrimary,
                        onTap: () {
                          LoginModel loginModel = LoginModel(
                            password: _passwordController.text,
                            username: _usernameController.text,
                          );

                          String data = loginModelToJson(loginModel);
                          print(data);

                          context.read<AuthNotifier>().loginFun(data, context);

                          // context.go('/home');
                        }),
                SizedBox(height: 10.h),
                Text(
                  " ---  OR  ---",
                  style: appStyle(14, AppColors.appGray, FontWeight.w400),
                ),
                SizedBox(height: 10.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 90.w),
                  child: Row(
                    children: [
                      const Icon(AntDesign.google, color: AppColors.appPrimary),
                      SizedBox(width: 20.w),
                      ReusableText(
                          text: "Connect With Gmail",
                          style:
                              appStyle(14, AppColors.appDark, FontWeight.w400)),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 140.h,
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: 70.w),
            child: GestureDetector(
              onTap: () {
                context.push('/signup');
              },
              child: Text(
                "Don't Have an Account? Sign Up Now,",
                style: appStyle(14, Colors.blue, FontWeight.w400),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
