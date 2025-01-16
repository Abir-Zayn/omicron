import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:omicron/src/common/services/storage.dart';
import 'package:omicron/src/common/utils/appColors.dart';
import 'package:omicron/src/const/resource.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _navigator();
    super.initState();
  }

  _navigator() async {
    await Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      if (Storage().getBool('firstOpen') == null) {
        // Go to the onboarding screen
        GoRouter.of(context).go('/onboarding');
      } else {
        // Go to the home screen/Login Screen
        GoRouter.of(context).go('/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appWhite,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(R.ASSETS_IMAGES_SPLASHSCREEN_PNG),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
