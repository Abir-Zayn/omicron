import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:omicron/pages/auth/views/login_screen.dart';
import 'package:omicron/pages/cart/controllers/cart_notifier.dart';
import 'package:omicron/pages/cart/hooks/fetch_cart.dart';
import 'package:omicron/pages/cart/widgets/cart_tile.dart';
import 'package:omicron/pages/products/views/product_screen.dart';
import 'package:omicron/src/common/services/storage.dart';
import 'package:omicron/src/common/utils/appColors.dart';
import 'package:omicron/src/widgets/app_style.dart';
import 'package:omicron/src/widgets/custom_button.dart';
import 'package:omicron/src/widgets/reusable_text.dart';
import 'package:omicron/src/widgets/shimmers/list_shimmer.dart';
import 'package:provider/provider.dart';

class CartScreen extends HookWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');
    final results = fetchCart();
    final cart = results.cart;
    final isLoading = results.isLoading;
    final refetch = results.refetch;
    final cartNotifier = Provider.of<CartNotifier>(context);

    if (accessToken == null) {
      return const LoginScreen();
    }
    if (isLoading) {
      return const Scaffold(
        body: ListShimmer(),
      );
    }

    double totalAmount = cart.fold(0, (sum, item) {
      final quantity = cartNotifier.quantities[item.id] ?? item.quantity;
      return sum + (double.parse(item.product.price) * quantity);
    });

    return Scaffold(
      appBar: AppBar(
        title: ReusableText(
            text: "Cart Items",
            style: appStyle(18, AppColors.appDark, FontWeight.w600)),
        actions: [
          Container(
            padding: const EdgeInsets.all(1),
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(color: AppColors.appPrimary, width: 1),
                right: BorderSide(color: AppColors.appPrimary, width: 1),
                top: BorderSide(color: AppColors.appPrimary, width: 1),
                bottom: BorderSide(color: AppColors.appPrimary, width: 1),
              ),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: IconButton(
              onPressed: () {
                //delete all the items in cart
                //Not have been implemented yet
              },
              icon: const Icon(CupertinoIcons.trash),
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 0.65.sh,
            // Wrap ListView in Expanded
            child: ListView(
              children: List.generate(cart.length, (i) {
                final cartItem = cart[i];
                return CartTileWidget(
                  cart: cartItem,
                  onDelete: () {
                    cartNotifier.deleteCart(cartItem.id, accessToken, refetch);
                  },
                  onUpdate: () {
                    cartNotifier.updateCart(cartItem.id, accessToken, refetch);
                  },
                  onTap: () {
                    //navigate to product page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductScreen(
                          productId: cartItem.product.id.toString(),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReusableText(
                  text: "Total Amount ",
                  style: appStyle(19, AppColors.appDark, FontWeight.w400),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(
                      text: "TK : ${totalAmount.toStringAsFixed(2)}",
                      style: appStyle(30, AppColors.appDark, FontWeight.w600),
                    ),
                    GradientBtn(
                      text: "Checkout",
                      btnColor:
                          totalAmount > 0 ? AppColors.appPrimary : Colors.grey,
                      btnHieght: 50,
                      btnWidth: 0.3.sw,
                      radius: 15,
                      onTap: totalAmount > 0 ? () {
                        //navigate to checkout page

                        context.push('/checkout');
                      } : null,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
