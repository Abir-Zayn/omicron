// ignore_for_file: use_super_parameters

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omicron/pages/auth/controllers/password_notifier.dart';
import 'package:omicron/src/common/utils/appColors.dart';
import 'package:provider/provider.dart';

import 'app_style.dart';

class PasswordField extends StatelessWidget {
  PasswordField({
    Key? key,
    required this.controller,
    this.focusNode,
    this.radius,
    this.hint,
  }) : super(key: key);

  final TextEditingController controller;
  final FocusNode? focusNode;
  final double? radius;
  String? hint = "Password";
  @override
  Widget build(BuildContext context) {
    return Consumer<PasswordNotifier>(
      builder: (context, passwordNotifier, child) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: TextFormField(
            cursorColor: Colors.black,
            textInputAction: TextInputAction.next,
            focusNode: focusNode,
            keyboardType: TextInputType.visiblePassword,
            controller: controller,
            obscureText: passwordNotifier.password,
            validator: (value) {
              if (value!.isEmpty) {
                return "Please enter a valid password";
              } else {
                return null;
              }
            },
            style: appStyle(12, AppColors.appDark, FontWeight.normal),
            decoration: InputDecoration(
              suffixIcon: GestureDetector(
                onTap: () {
                  passwordNotifier.setPassword();
                },
                child: Icon(
                  passwordNotifier.password
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: AppColors.appGrayLight,
                ),
              ),
              hintText: hint,
              prefixIcon: const Icon(
                CupertinoIcons.lock_circle,
                color: AppColors.appGrayLight,
                size: 26,
              ),
              isDense: true,
              contentPadding: const EdgeInsets.all(6),
              hintStyle: appStyle(12, AppColors.appGray, FontWeight.normal),
              // contentPadding: EdgeInsets.only(left: 24),
              errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red, width: 0.5),
                  borderRadius:
                      BorderRadius.all(Radius.circular(radius ?? 12))),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: AppColors.appPrimary, width: 0.5),
                  borderRadius:
                      BorderRadius.all(Radius.circular(radius ?? 12))),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: AppColors.appRed, width: 0.5),
                  borderRadius:
                      BorderRadius.all(Radius.circular(radius ?? 12))),
              disabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: AppColors.appGray, width: 0.5),
                  borderRadius:
                      BorderRadius.all(Radius.circular(radius ?? 12))),
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: AppColors.appGray, width: 0.5),
                  borderRadius:
                      BorderRadius.all(Radius.circular(radius ?? 12))),
              border: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppColors.appPrimary, width: 0.5),
                borderRadius: BorderRadius.all(
                  Radius.circular(radius ?? 12),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
