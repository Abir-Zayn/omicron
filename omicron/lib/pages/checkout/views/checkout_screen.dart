import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:omicron/pages/cart/controllers/cart_notifier.dart';
import 'package:omicron/pages/cart/hooks/fetch_cart.dart';
import 'package:omicron/pages/cart/views/cart_screen.dart';
import 'package:omicron/src/common/utils/appColors.dart';
import 'package:omicron/src/widgets/app_style.dart';
import 'package:omicron/src/widgets/back_button.dart';
import 'package:omicron/src/widgets/reusable_text.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    final results = fetchCart();
    final cart = results.cart;
    final isLoading = results.isLoading;
    final refetch = results.refetch;
    final cartNotifier = Provider.of<CartNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        leading: AppBackButton(
          onTap: () {
            context.pop();
          },
        ),
        title: ReusableText(
            text: 'Check out',
            style: appStyle(15, AppColors.appDark, FontWeight.w400)),
      ),
      body: Consumer<CartNotifier>(
        builder: (context, cartNotifier, child) {
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            children: [
              //add address form
              SizedBox(height: 10.h),

              SizedBox(
                height: ScreenUtil().screenHeight * 0.5,
                child: Column(
                  children: List.generate(
                    cart.length,
                    (i) {
                      return Container();
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
