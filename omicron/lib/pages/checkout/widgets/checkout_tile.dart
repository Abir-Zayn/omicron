import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:omicron/pages/cart/controllers/cart_notifier.dart';
import 'package:omicron/pages/cart/models/cart_models.dart';
import 'package:omicron/src/common/utils/appColors.dart';
import 'package:omicron/src/widgets/app_style.dart';
import 'package:omicron/src/widgets/reusable_text.dart';
import 'package:provider/provider.dart';

class CheckoutTile extends StatefulWidget {
  const CheckoutTile({
    super.key,
    required this.cart,
  });

  final CartModel cart;

  @override
  State<CheckoutTile> createState() => _CheckoutTileState();
}

class _CheckoutTileState extends State<CheckoutTile> {
  void initstate() {
    super.initState();
    final cartNotifier = Provider.of<CartNotifier>(context, listen: false);
    cartNotifier.initializeQuantity(widget.cart.id, widget.cart.quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartNotifier>(
      builder: (context, cartNotifier, child) {
        return Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
          child: Container(
            width: ScreenUtil().screenWidth,
            height: 120.h,
            decoration: BoxDecoration(
                color: const Color.fromARGB(206, 255, 255, 255),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3))
                ]),
            child: SizedBox(
              height: 80.h,
              child: Row(
                children: [
                  //cart product photos
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: widget.cart.product.imageUrls[0],
                      fit: BoxFit.cover,
                    ),
                  ),

                  //cart product title and price
                  Expanded(
                    child: GestureDetector(
                      //by clicking on it, it will direct to the product page
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ReusableText(
                              text: widget.cart.product.title,
                              style: appStyle(
                                  16, AppColors.appDark, FontWeight.w600),
                            ),
                            const SizedBox(height: 5),
                            ReusableText(
                              text: '${widget.cart.product.price} TK',
                              style: appStyle(
                                  14, AppColors.appDark, FontWeight.w400),
                            ),
                            const SizedBox(height: 5),
                            ReusableText(
                              text:
                                  'Criteria: ${widget.cart.size.join(", ")} ${widget.cart.color.join(", ")}',
                              style: appStyle(
                                  14, AppColors.appDark, FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40.h,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 30.w,
                                  child: Center(
                                    child: ReusableText(
                                      text:
                                          '${cartNotifier.quantities[widget.cart.id] ?? widget.cart.quantity}',
                                      style: appStyle(16, AppColors.appDark,
                                          FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        //delete button
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
