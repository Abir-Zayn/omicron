import 'package:flutter/material.dart';
import 'package:omicron/pages/auth/views/login_screen.dart';
import 'package:omicron/pages/wishlist/widgets/wishlist_list.dart';
import 'package:omicron/src/common/services/storage.dart';
import 'package:omicron/src/common/utils/appColors.dart';
import 'package:omicron/src/common/utils/app_strings.dart';
import 'package:omicron/src/widgets/app_style.dart';
import 'package:omicron/src/widgets/reusable_text.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');
    if (accessToken == null) {
      return const LoginScreen();
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: ReusableText(
            text: AppStrings.appWishlist,
            style: appStyle(18, AppColors.appDark, FontWeight.w600)),
      ),
      body: const WishlistWidget(),
    );
  }
}
