import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:omicron/src/common/utils/appColors.dart';
import 'package:omicron/src/const/constants.dart';

class HomeSlider extends StatelessWidget {
  const HomeSlider({super.key});

  @override
  Widget build(BuildContext context) {
    //ClipRRect is a widget that ensures the corner of the child widget is rounded.
    return ClipRRect(
      borderRadius: appRadiusAll,
      child: Stack(
        children: [
          SizedBox(
            height: ScreenUtil().screenHeight * 0.19,
            width: ScreenUtil().screenWidth,
            child: ImageSlideshow(
              //Sets the color of the slide indicator, which shows the current slide.
              indicatorColor: AppColors.appWhite,
              //A callback function that triggers whenever the slide changes.
              onPageChanged: (page) {
                (page);
              },
              autoPlayInterval: 5000,
              isLoop: true,
              children: List.generate(
                images.length,
                (i) {
                  //handles network image loading efficiently
                  // if the Img doesn't load, it will show the placeholder image
                  return CachedNetworkImage(
                      placeholder: placeholder,
                      errorWidget: errorWidget,
                      imageUrl: images[i],
                      fit: BoxFit.cover);
                },
              ),
            ),
          ),

          /* `Following has commented out, Its for the better UI dealing. Only SLider UI has been
            ` showing up for Now. 
          */
          // Positioned(
          //   right: 80,
          //   height: ScreenUtil().scaleHeight * 0.1,
          //   width: ScreenUtil().screenWidth,
          //   child: Padding(
          //     padding: EdgeInsets.symmetric(horizontal: 20.w),
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: [
          //         Text(
          //           "Discount 25% off \n for New Users",
          //           style: appStyle(20, AppColors.appDark, FontWeight.normal),
          //         ),
          //         SizedBox(
          //           height: 10.h,
          //         ),
          //         GradientBtn(
          //           text: "Buy Now",
          //           btnWidth: 150.w,
          //         )
          //       ],
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}

//First we're focusing on the Single Vendor Shop therefore I will be using custom methods which will
//directly fetch product images from django server however right now it will fetch images from general web
List<String> images = [
  'https://img.freepik.com/free-vector/mobile-tech-banner-template_23-2148818626.jpg?w=1380&t=st=1729110294~exp=1729110894~hmac=dded16227ae5f24b972aa2f647370e86a98cbf69a1434688fc79429d6c24b810',
  'https://img.freepik.com/free-psd/sales-banner-template-with-image_23-2148149655.jpg?t=st=1729110471~exp=1729114071~hmac=9fc5fa4a8d9b8a4760d67e31f8eeb3a6ab867eb632351154b0b3821e5e6343b0&w=1380',
  'https://img.freepik.com/free-vector/electronics-store-sale-banner-template_23-2151173125.jpg?t=st=1729110500~exp=1729114100~hmac=664c2b50b50105ec099c9c7e22caffa67a72e62d13297f868decc70eecbe380d&w=1380'
];
