import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:omicron/pages/cart/controllers/cart_notifier.dart';
import 'package:omicron/pages/cart/models/createCart_model.dart';
import 'package:omicron/pages/products/controllers/color_sizes_model.notifier.dart';
import 'package:omicron/pages/products/controllers/product_notfier.dart';
import 'package:omicron/pages/products/widgets/colorSeclection_widget.dart';
import 'package:omicron/pages/products/widgets/explendable_widget.dart';
import 'package:omicron/pages/products/widgets/product_bottombar.dart';
import 'package:omicron/pages/products/widgets/product_sizes_widget.dart';
import 'package:omicron/pages/products/widgets/similar_products.dart';
import 'package:omicron/pages/wishlist/controllers/wishlist_notifier.dart';
import 'package:omicron/src/common/services/storage.dart';
// import 'package:omicron/src/common/services/storage.dart';
import 'package:omicron/src/common/utils/appColors.dart';
import 'package:omicron/src/const/constants.dart';
import 'package:omicron/src/widgets/app_style.dart';
import 'package:omicron/src/widgets/back_button.dart';
import 'package:omicron/src/widgets/flash_message.dart';
import 'package:omicron/src/widgets/login_bottom_sheet.dart';
// import 'package:omicron/src/widgets/login_bottom_sheet.dart';
import 'package:omicron/src/widgets/reusable_text.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key, required this.productId, this.onPressed});

  final String productId;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');

    return Consumer<ProductNotfier>(
      builder: (context, ProductNotfier, child) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.white,
                expandedHeight: 320.h,
                collapsedHeight: 65.h,
                floating: false,
                pinned: true,
                leading: const AppBackButton(),
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: GestureDetector(
                      onTap: () {
                        if (accessToken == null) {
                          loginBottomSheet(context);
                        } else {
                          context.read<WishlistNotifier>().addRemoveWishList(
                              ProductNotfier.product!.id, () {});
                        }
                      },
                      child: const CircleAvatar(
                          backgroundColor: AppColors.appSecondaryLight,
                          child: Icon(
                            AntDesign.heart,
                            color: AppColors.appRed,
                            size: 16,
                          )),
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  background: SizedBox(
                    height: 415.h,
                    child: ImageSlideshow(
                      //Sets the color of the slide indicator, which shows the current slide.
                      indicatorColor: AppColors.appWhite,
                      //A callback function that triggers whenever the slide changes.
                      onPageChanged: (page) {
                        (page);
                      },
                      autoPlayInterval: 15000,
                      isLoop: ProductNotfier.product!.imageUrls.length > 1
                          ? true
                          : false,
                      children: List.generate(
                        ProductNotfier.product!.imageUrls.length,
                        (i) {
                          //handles network image loading efficiently
                          // if the Img doesn't load, it will show the placeholder image
                          return CachedNetworkImage(
                              placeholder: placeholder,
                              errorWidget: errorWidget,
                              height: 415.h,
                              imageUrl: ProductNotfier.product!.imageUrls[i],
                              fit: BoxFit.cover);
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                  child: SizedBox(
                height: 10.h,
              )),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),

                  // On the same line it will display the product tag and the rating
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          color: AppColors.appPrimary,
                          child: Text(
                              ProductNotfier.product!.itemType.toUpperCase(),
                              style: appStyle(
                                  11, AppColors.appWhite, FontWeight.w600)),
                        ),
                      ),

                      //This will fetch the products rating, icons and display it
                      Row(
                        children: [
                          const Icon(
                            AntDesign.star,
                            color: AppColors.appGold,
                            size: 16,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          ReusableText(
                              text: ProductNotfier.product!.rating
                                  .toStringAsFixed(1),
                              style: appStyle(
                                  16, AppColors.appDark, FontWeight.w500))
                        ],
                      )
                    ],
                  ),
                ),
              ),

              //Product Title
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(left: 8.w, bottom: 10.h),
                  child: ReusableText(
                    text: ProductNotfier.product!.title,
                    style: appStyle(20, AppColors.appDark, FontWeight.w600),
                  ),
                ),
              ),

              //This Row reponsible for giving the information of how many products are left
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 6.h, right: 5.w, left: 8.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 25.h,
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        decoration: BoxDecoration(
                            color: AppColors.appGreen.withOpacity(0.2),
                            borderRadius: appRadiusAll),
                        child: ReusableText(
                          text: "- ${ProductNotfier.product!.discount} ",
                          style: appStyle(
                              14, AppColors.appGrayDark, FontWeight.w500),
                        ),
                      ),
                      ReusableText(
                        text:
                            "${ProductNotfier.product!.stock} of these are left",
                        style: appStyle(
                            12, AppColors.appGrayDark, FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),

              //Responsible for showing up the product details along with view all and view less feature
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: ExplendableWidget(
                      text: ProductNotfier.product!.description),
                ),
              ),

              //Showing up the Product Size Title text
              SliverToBoxAdapter(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: ReusableText(
                        text: "Select Size",
                        style:
                            appStyle(15, AppColors.appDark, FontWeight.w500))),
              ),

              //Select the product Size
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(2.w),
                  child: const ProductSizesWidget(),
                ),
              ),

              //Showing up the Product "Select Color" title text
              SliverToBoxAdapter(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: ReusableText(
                        text: "Select Color",
                        style:
                            appStyle(15, AppColors.appDark, FontWeight.w500))),
              ),

              // Select your Product color
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(2.w),
                  child: const ColorseclectionWidget(),
                ),
              ),

              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Text("Similar Products",
                          style:
                              appStyle(16, AppColors.appDark, FontWeight.w600)),
                    ),
                    const SimilarProducts(),
                  ],
                ),
              )
            ],
          ),
          bottomNavigationBar: ProductBottomBar(
            onPressed: () {
              if (accessToken == null) {
                loginBottomSheet(context);
              } else {
                //Get the Selected Size and Color

                String selectedSize =
                    context.read<ColorSizeModelNotifier>().size;
                String selectedColor =
                    context.read<ColorSizeModelNotifier>().colors;

                //Create a cart model
                CreatecartModel cartData = CreatecartModel(
                    product: ProductNotfier.product!.id,
                    size: [selectedSize],
                    color: [selectedColor]);

                //Add the product to the cart
                context.read<CartNotifier>().addToCart(cartData, accessToken,
                    () {
                  var snackbar = SnackBar(
                    content: FlashMessageScreen(
                        text: "Product added to cart",
                        messgaeType: MessageType.success,
                        onClose: () => ScaffoldMessenger.of(context)
                            .hideCurrentSnackBar()),
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                });

                // Show a success message
              }

              var snackbar = SnackBar(
                content: FlashMessageScreen(
                    text: "Missing Size or Color",
                    messgaeType: MessageType.error,
                    onClose: () =>
                        ScaffoldMessenger.of(context).hideCurrentSnackBar()),
                elevation: 0,
                backgroundColor: Colors.transparent,
              );
              if (context.read<ColorSizeModelNotifier>().colors == '' ||
                  context.read<ColorSizeModelNotifier>().size == '') {
                log("Error: Size or Color not selected");
                // Debug print
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
              } else {
                // Handle the case when size and color are selected
                log("Size and Color selected"); // Debug print
              }
              // }
            },
            price: ProductNotfier.product!.price.toStringAsFixed(2),
          ),
        );
      },
    );
  }
}
