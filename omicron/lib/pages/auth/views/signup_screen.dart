import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:omicron/pages/auth/controllers/auth_notifier.dart';
import 'package:omicron/pages/auth/models/signup_model.dart';
import 'package:omicron/src/common/utils/appColors.dart';
import 'package:omicron/src/widgets/app_style.dart';
import 'package:omicron/src/widgets/back_button.dart';
import 'package:omicron/src/widgets/custom_button.dart';
import 'package:omicron/src/widgets/email_textfield.dart';
import 'package:omicron/src/widgets/flash_message.dart';
import 'package:omicron/src/widgets/password_field.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController =
      TextEditingController();
  late final TextEditingController _userNameController =
      TextEditingController();
  late final TextEditingController _confirmpasswordController =
      TextEditingController();
  final FocusNode _passwordNode = FocusNode();
  final FocusNode _confirmpasswordNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _userNameController.dispose();
    _passwordNode.dispose();
    _confirmpasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appWhite,
      appBar: AppBar(
        leading: AppBackButton(
          onTap: () {
            context.go('/home');
          },
        ),
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
            "Get your favourite shoes by a simple gesture? \n What are you waiting for? Join Now?",
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
                  hintText: "Enter Email",
                  controller: _emailController,
                  prefixIcon: const Icon(CupertinoIcons.mail_solid,
                      size: 18, color: AppColors.appGray),
                  keyboardType: TextInputType.emailAddress,
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(_passwordNode);
                  },
                ),
                SizedBox(height: 20.h),
                EmailTextField(
                  radius: 20,
                  focusNode: _passwordNode,
                  hintText: "Enter User Name",
                  controller: _userNameController,
                  prefixIcon: const Icon(CupertinoIcons.person_solid,
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
                SizedBox(height: 10.h),
                PasswordField(
                    hint: "Confirm Password",
                    controller: _confirmpasswordController,
                    focusNode: _confirmpasswordNode,
                    radius: 20),
                SizedBox(height: 20.h),

                //Sign Up Button
                context.watch<AuthNotifier>().isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          backgroundColor: AppColors.appPrimary,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(AppColors.appDark),
                        ),
                      )
                    : GradientBtn(
                        text: "Sign Up",
                        btnHieght: 45,
                        radius: 20,
                        btnWidth: ScreenUtil().screenWidth - 80,
                        btnColor: AppColors.appPrimary,
                        onTap: () {
                          String email = _emailController.text.trim();
                          String username = _userNameController.text.trim();
                          String password = _passwordController.text.trim();
                          String confirmPassword =
                              _confirmpasswordController.text.trim();

                           var snackBar = SnackBar(
                            content: FlashMessageScreen(
                              text:
                                  "You haven't filled all the required data. ",
                              messgaeType: MessageType.error,
                              onClose :() => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                            ),
                            elevation: 0,
                            backgroundColor: Colors.transparent,

                            
                          );

                          if (email.isEmpty ||
                              username.isEmpty ||
                              password.isEmpty ||
                              confirmPassword.isEmpty ||
                              password != confirmPassword) {
                            // Show Snackbar for empty fields
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            SignUpModel signUpModel = SignUpModel(
                              email: email,
                              username: username,
                              password: password,
                            );

                            String data = signUpModelToJson(signUpModel);
                            context
                                .read<AuthNotifier>()
                                .signUpFun(data, context);

                            // context.go('/home');
                          }
                        },
                      ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 100.h,
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: 20.w),
            child: GestureDetector(
              onTap: () {
                context.go('/login');
              },
              child: Text(
                "Already Have an Account? Sign In Now,",
                style: appStyle(14, Colors.blue, FontWeight.w400),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
