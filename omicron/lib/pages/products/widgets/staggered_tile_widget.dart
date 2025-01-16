//This will represent the products in a staggered grid view

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:like_button/like_button.dart';
import 'package:omicron/pages/products/controllers/product_notfier.dart';
import 'package:omicron/pages/products/models/products_model.dart';
import 'package:omicron/src/common/utils/appColors.dart';
import 'package:omicron/src/widgets/app_style.dart';
import 'package:omicron/src/widgets/reusable_text.dart';
import 'package:provider/provider.dart';

class StaggeredTileWidget extends StatelessWidget {
  const StaggeredTileWidget(
      {super.key, required this.index, required this.product, this.ontap});

  final int index;
  final Products product;
  final void Function()? ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<ProductNotfier>().setProduct(product);
        context.push('/product/${product.id}');
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: index % 2 == 0 ? 143.h : 150.h,
                width: double.infinity,
                color: Colors.transparent,
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      height: index % 2 == 0 ? 160.h : 160.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      imageUrl: product.imageUrls[0],
                    ),

                    //Favorite Product or Not Segment
                    Positioned(
                        right: 10.h,
                        top: 10.h,
                        child: LikeButton(
                          size: 20,
                          circleColor: CircleColor(
                            start: AppColors.appPrimary,
                            end: AppColors.appPrimary.withOpacity(0.2),
                          ),
                          bubblesColor:  BubblesColor(
                            dotPrimaryColor: AppColors.appPrimary.withOpacity(0.2),
                            dotSecondaryColor: AppColors.appOffWhite,
                          ),
                          likeBuilder: (bool isLiked) {
                            return Container(
                              padding: EdgeInsets.all(2.h),
                              decoration: const BoxDecoration(
                                color: AppColors.appOffWhite,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                AntDesign.heart,
                                color: AppColors.appPrimary,
                                size: 16,
                              ),
                            );
                          },
                          onTap: (isLiked) async {
                            if (ontap != null) {
                              ontap!();
                            }
                            return !isLiked;
                          },
                        ))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 2.h,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Text(
                        product.title,
                        overflow: TextOverflow.ellipsis,
                        style: appStyle(13, AppColors.appDark, FontWeight.w600),
                      ),
                    ),
                    Row(
                      children: [
                        //Rating Icon
                        const Icon(
                          AntDesign.star,
                          color: AppColors.appGold,
                          size: 14,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),

                        //Raing Score
                        ReusableText(
                          text: product.rating.toStringAsFixed(1),
                          style:
                              appStyle(13, AppColors.appGray, FontWeight.w500),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              //Fetching the price of the product
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: ReusableText(
                    text: "${product.price} tk",
                    style: appStyle(15, AppColors.appDark, FontWeight.w600),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
