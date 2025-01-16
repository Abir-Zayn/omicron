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

class CartTileWidget extends StatefulWidget {
  const CartTileWidget({
    super.key,
    required this.cart,
    required this.onDelete,
    required this.onUpdate,
    required this.onTap,
  });

  final CartModel cart;
  final VoidCallback onDelete;
  final VoidCallback onUpdate;
  final VoidCallback onTap;

  @override
  State<CartTileWidget> createState() => _CartTileWidgetState();
}

class _CartTileWidgetState extends State<CartTileWidget> {
  void initstate() {
    super.initState();
    final cartNotifier = Provider.of<CartNotifier>(context, listen: false);
    cartNotifier.initializeQuantity(widget.cart.id, widget.cart.quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartNotifier>(
      builder: (context, cartNotifier, child) {
        return GestureDetector(
          onTap: widget.onTap,
          child: Padding(
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
                                  Container(
                                    color: AppColors.appPrimary,
                                    child: IconButton(
                                      onPressed: () {
                                        cartNotifier.decrement(widget.cart.id);
                                        widget.onUpdate();
                                      },
                                      icon: const Icon(
                                        CupertinoIcons.minus,
                                        size: 17,
                                        color: AppColors.appOffWhite,
                                      ),
                                    ),
                                  ),
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
                                  Container(
                                    color: AppColors.appPrimary,
                                    child: IconButton(
                                      onPressed: () {
                                        cartNotifier.increment(widget.cart.id);
                                        widget.onUpdate();
                                      },
                                      icon: const Icon(
                                        CupertinoIcons.plus,
                                        size: 17,
                                        color: AppColors.appOffWhite,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          //delete button
                          const SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                color: AppColors.appRed,
                                width: 1,
                              ),
                            ),
                            child: IconButton(
                              onPressed: widget.onDelete,
                              icon: const Icon(
                                CupertinoIcons.trash,
                                size: 18,
                                color: AppColors.appRed,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
