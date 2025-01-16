import 'package:flutter/material.dart';
import 'package:omicron/pages/categories/models/catrgories_model.dart';
import 'package:omicron/pages/products/models/products_model.dart';
import 'package:omicron/src/const/resource.dart';

import '../common/utils/appColors.dart';

LinearGradient appGradient = const LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    AppColors.appPrimaryLight,
    AppColors.appWhite,
    AppColors.appPrimary,
  ],
);

LinearGradient appPGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    AppColors.appPrimaryLight,
    AppColors.appPrimaryLight.withOpacity(0.7),
    AppColors.appPrimary,
  ],
);

LinearGradient appBtnGradient = const LinearGradient(
  begin: Alignment.bottomLeft,
  end: Alignment.bottomRight,
  colors: [
    AppColors.appPrimaryLight,
    AppColors.appWhite,
  ],
);

BorderRadiusGeometry appClippingRadius = const BorderRadius.only(
  topLeft: Radius.circular(20),
  topRight: Radius.circular(20),
);

BorderRadiusGeometry appRadiusAll = BorderRadius.circular(12);

BorderRadiusGeometry appRadiusTop = const BorderRadius.only(
  topLeft: Radius.circular(9),
  topRight: Radius.circular(9),
);

BorderRadiusGeometry appRadiusBottom = const BorderRadius.only(
  bottomLeft: Radius.circular(12),
  bottomRight: Radius.circular(12),
);

Widget Function(BuildContext, String)? placeholder = (p0, p1) => Image.asset(
      R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
      fit: BoxFit.cover,
    );

Widget Function(BuildContext, String, Object)? errorWidget =
    (p0, p1, p3) => Image.asset(
          R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
          fit: BoxFit.cover,
        );

// List<String> images = [
//   "https://firebasestorage.googleapis.com/v0/b/authenification-b4dc9.appspot.com/o/uploads%2Fslider1.png?alt=media&token=8b27e621-e5ea-4ba4-ab15-0302d02c75f3",
//   "https://firebasestorage.googleapis.com/v0/b/authenification-b4dc9.appspot.com/o/uploads%2Fslider1.png?alt=media&token=8b27e621-e5ea-4ba4-ab15-0302d02c75f3",
//   "https://firebasestorage.googleapis.com/v0/b/authenification-b4dc9.appspot.com/o/uploads%2Fslider1.png?alt=media&token=8b27e621-e5ea-4ba4-ab15-0302d02c75f3",
//   "https://firebasestorage.googleapis.com/v0/b/authenification-b4dc9.appspot.com/o/uploads%2Fslider1.png?alt=media&token=8b27e621-e5ea-4ba4-ab15-0302d02c75f3",
//   "https://firebasestorage.googleapis.com/v0/b/authenification-b4dc9.appspot.com/o/uploads%2Fslider1.png?alt=media&token=8b27e621-e5ea-4ba4-ab15-0302d02c75f3",
// ];

// [{"title":"Sneakers","id":3,"imageUrl":"https://firebasestorage.googleapis.com/v0/b/authenification-b4dc9.appspot.com/o/uploads%2Frunning_shoe.svg?alt=media&token=0dcb0e57-315e-457c-89dc-1233f6421368"},{"title":"T-Shirts","id":5,"imageUrl":"https://firebasestorage.googleapis.com/v0/b/authenification-b4dc9.appspot.com/o/uploads%2Fjersey.svg?alt=media&token=6ca7eabd-54b3-47bb-bb8f-41c3a8920171"},{"title":"Jackets","id":4,"imageUrl":"https://firebasestorage.googleapis.com/v0/b/authenification-b4dc9.appspot.com/o/uploads%2Fjacket.svg?alt=media&token=ffdc9a1e-917f-4e8f-b58e-4df2e6e8587e"},{"title":"Dresses","id":2,"imageUrl":"https://firebasestorage.googleapis.com/v0/b/authenification-b4dc9.appspot.com/o/uploads%2Fdress.svg?alt=media&token=cf832383-4c8a-4ee1-9676-b66c4d515a1c"},{"title":"Pants","id":1,"imageUrl":"https://firebasestorage.googleapis.com/v0/b/authenification-b4dc9.appspot.com/o/uploads%2Fjeans.svg?alt=media&token=eb62f916-a4c2-441a-a469-5684f1a62526"}]

List<Categories> categories = [
  Categories(
      title: "Nike",
      id: 1,
      imageUrl:
          "https://firebasestorage.googleapis.com/v0/b/omicron-538c3.appspot.com/o/nike_logo.svg?alt=media&token=299bc94b-daa3-40fd-b503-f60872c3153e"),
  Categories(
      title: "Addidas",
      id: 2,
      imageUrl:
          "https://firebasestorage.googleapis.com/v0/b/omicron-538c3.appspot.com/o/adidas_logo.svg?alt=media&token=162aea13-0bfd-487d-9609-400c8be8d690"),
  Categories(
      title: "Puma",
      id: 3,
      imageUrl:
          "https://firebasestorage.googleapis.com/v0/b/omicron-538c3.appspot.com/o/puma_logo.svg?alt=media&token=8f64898c-a23c-4a69-9e97-9681677c3a58"),
  Categories(
      title: "Asics",
      id: 4,
      imageUrl:
          "https://firebasestorage.googleapis.com/v0/b/omicron-538c3.appspot.com/o/asics-6.svg?alt=media&token=fee590e0-9791-45a5-b1d7-ffbf27b920eb"),
  Categories(
      title: "Apex",
      id: 5,
      imageUrl:
          "https://firebasestorage.googleapis.com/v0/b/omicron-538c3.appspot.com/o/apex.svg?alt=media&token=90a94b62-0cf9-4481-a723-97efc7a56e14"),
  Categories(
      title: "Bata",
      id: 6,
      imageUrl:
          "https://firebasestorage.googleapis.com/v0/b/omicron-538c3.appspot.com/o/bata.svg?alt=media&token=da248345-5ee3-499f-84f1-ae39173165a6"),
  Categories(
      title: "Jonnie Walker",
      id: 7,
      imageUrl:
          "https://firebasestorage.googleapis.com/v0/b/omicron-538c3.appspot.com/o/johnnie-walker-7.svg?alt=media&token=30e8863c-6295-4e23-aaef-dbd2c54012ee"),
  Categories(
      title: "Famous FootWear",
      id: 8,
      imageUrl:
          "https://firebasestorage.googleapis.com/v0/b/omicron-538c3.appspot.com/o/famous-footwear-1.svg?alt=media&token=e4f68d4f-8a3d-46bb-aacb-d671fc67f94b")
];

// // var products = [
//   {
//     "id": 3,
//     "title": "Converse Chuck Taylor All Star",
//     "price": 60.0,
//     "description":
//         "The classic Chuck Taylor All Star sneaker from Converse, featuring a timeless design and comfortable fit.",
//     "is_featured": true,
//     "clothesType": "kids",
//     "ratings": 4.333333333333333,
//     "colors": ["black", "white", "red"],
//     "imageUrls": [
//       "https://media.cnn.com/api/v1/images/stellar/prod/220210051008-04-lv-virgil-abloh.jpg?q=w_2000,c_fill/f_webp",
//       "https://media.cnn.com/api/v1/images/stellar/prod/220210051008-04-lv-virgil-abloh.jpg?q=w_2000,c_fill/f_webp"
//     ],
//     "sizes": ["7", "8", "9", "10", "11"],
//     "created_at": "2024-06-06T07:57:45Z",
//     "category": 3,
//     "brand": 1
//   },
//   {
//     "id": 1,
//     "title": "LV Trainers",
//     "price": 798.88,
//     "description":
//         "LV Trainers blend sleek style with athletic functionality, featuring bold logos, premium materials, and comfortable designs that elevate your everyday look with a touch of luxury.",
//     "is_featured": true,
//     "clothesType": "women",
//     "ratings": 4.5,
//     "colors": ["white", "black", "red"],
//     "imageUrls": [
//       "https://media.cnn.com/api/v1/images/stellar/prod/220210051008-04-lv-virgil-abloh.jpg?q=w_2000,c_fill/f_webp",
//       "https://media.cnn.com/api/v1/images/stellar/prod/220210051008-04-lv-virgil-abloh.jpg?q=w_2000,c_fill/f_webp"
//     ],
//     "sizes": ["7", "8", "9", "10", "11"],
//     "created_at": "2024-06-06T07:49:15Z",
//     "category": 3,
//     "brand": 1
//   },
//   {
//     "id": 2,
//     "title": "Adidas Ultraboost",
//     "price": 180.0,
//     "description":
//         "xperience the comfort and energy return of the Ultraboost, designed for running and everyday wear.",
//     "is_featured": true,
//     "clothesType": "unisex",
//     "ratings": 5.0,
//     "colors": ["navy", "grey", "blue"],
//     "imageUrls": [
//       "https://media.cnn.com/api/v1/images/stellar/prod/220210051008-04-lv-virgil-abloh.jpg?q=w_2000,c_fill/f_webp",
//       "https://media.cnn.com/api/v1/images/stellar/prod/220210051008-04-lv-virgil-abloh.jpg?q=w_2000,c_fill/f_webp"
//     ],
//     "sizes": ["7", "8", "9", "10", "11"],
//     "created_at": "2024-06-06T07:55:20Z",
//     "category": 3,
//     "brand": 1
//   }
// ];

List<Products> productlist = [
  Products(
    id: 3,
    title: "Converse Chuck Taylor All Star",
    price: 60.0,
    description:
        "The classic Chuck Taylor All Star sneaker from Converse, featuring a timeless design and comfortable fit.",
    isFeatured: true,
    itemType: "men",
    rating: 4.333333333333333,
    colors: ["black", "white", "red"],
    imageUrls: [
      "https://media.cnn.com/api/v1/images/stellar/prod/220210051008-04-lv-virgil-abloh.jpg?q=w_2000,c_fill/f_webp",
      "https://media.cnn.com/api/v1/images/stellar/prod/220210051008-04-lv-virgil-abloh.jpg?q=w_2000,c_fill/f_webp"
    ],
    sizes: ["7", "8", "9", "10", "11"],
    createdAt: DateTime.parse("2024-06-06T07:57:45Z"),
    category: 3,
    brand: 1,
    discount: 20,
    stock: 10,
  ),
  Products(
    id: 1,
    title: "LV Trainers",
    price: 798.88,
    description:
        "LV Trainers blend sleek style with athletic functionality, featuring bold logos, premium materials, and comfortable designs that elevate your everyday look with a touch of luxury.",
    isFeatured: true,
    itemType: "women",
    rating: 4.5,
    colors: ["white", "black", "red"],
    imageUrls: [
      "https://media.cnn.com/api/v1/images/stellar/prod/220210051008-04-lv-virgil-abloh.jpg?q=w_2000,c_fill/f_webp",
      "https://media.cnn.com/api/v1/images/stellar/prod/220210051008-04-lv-virgil-abloh.jpg?q=w_2000,c_fill/f_webp"
    ],
    sizes: ["7", "8", "9", "10", "11"],
    createdAt: DateTime.parse("2024-06-06T07:49:15Z"),
    category: 3,
    brand: 1,
    stock: 10,
    discount: 25,
  ),
  Products(
      id: 2,
      title: "Adidas Ultraboost",
      price: 180.0,
      description:
          "Style, speed and comfort all come together in one of the most iconic shoes in the game. adidas Ultraboost shoes and sneakers come in a range of styles, but they all have one thing in common, they ride on an adidas Boost midsole. Full-length adidas Boost provides outstanding energy return while cushioning every step so no matter where you go or what you're doing, your feet feel great. If you're looking for stylish sneakers, adidas has the Ultraboost 1.0.",
      isFeatured: true,
      itemType: "men",
      rating: 5.0,
      colors: ["navy", "grey", "blue"],
      imageUrls: [
        "https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/62ee37e147734555a65c73b6bb88963c_9366/Ultraboost_5X_Shoes_White_JI3057_02_standard.jpg",
        "https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/7c0f1a7294ad4bf0a074ba303a89671c_9366/Ultraboost_5X_Shoes_White_IH0638_HM2.jpg"
      ],
      sizes: ["7", "8", "9", "10", "11"],
      createdAt: DateTime.parse("2024-06-06T07:55:20Z"),
      category: 3,
      brand: 1,
      stock: 10,
      discount: 40.5),
  Products(
      id: 4,
      title: "Puma x LAMELO",
      price: 180.0,
      description:
          "Intel Core i3-1115G4 Processor.14″ 2K (2160 × 1440) IPS, 90% Screen-to-body Ratio, 3:2 Aspect Ratio, 400 nits Peak Brightness, 330 nits Typical Brightness, 100% sRGB, 1500: 1 Contrast Ratio, Full Vision Display with Corning Gorilla Glass",
      isFeatured: true,
      itemType: "kids",
      rating: 5.0,
      colors: ["navy", "grey", "blue"],
      imageUrls: [
        "https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_2000,h_2000/global/310868/01/fnd/PNA/fmt/png/PUMA-x-LAMELO-BALL-LaFranc%C3%A9-Assist-Men's-Shoes",
        "https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_2000,h_2000/global/310868/01/bv/fnd/PNA/fmt/png/PUMA-x-LAMELO-BALL-LaFranc%C3%A9-Assist-Men's-Shoes"
      ],
      sizes: ["7", "8", "9", "10", "11"],
      createdAt: DateTime.parse("2024-06-06T07:55:20Z"),
      category: 3,
      brand: 1,
      stock: 10,
      discount: 30),
];

String avatar =
    'https://firebasestorage.googleapis.com/v0/b/authenification-b4dc9.appspot.com/o/uploads%2Favatar.png?alt=media&token=7da81de9-a163-4296-86ac-3194c490ce15';


// class _buildtextfield extends StatelessWidget {
//   const _buildtextfield({
//     Key? key,
//     required this.hintText,
//     required this.controller,
//     required this.onSubmitted,
//     this.keyboard,
//     this.readOnly,
//   }) : super(key: key);

//   final TextEditingController controller;
//   final String hintText;
//   final TextInputType? keyboard;
//   final void Function(String)? onSubmitted;
//   final bool? readOnly;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 20.0),
//       child: TextField(
//           keyboardType: keyboard,
//           readOnly: readOnly ?? false,
//           decoration: InputDecoration(
//               hintText: hintText,
//               errorBorder: const UnderlineInputBorder(
//                 borderSide: BorderSide(color: Kolors.kRed, width: 0.5),
//               ),
//               focusedBorder: const UnderlineInputBorder(
//                 borderSide: BorderSide(color: Kolors.kPrimary, width: 0.5),
//               ),
//               focusedErrorBorder: const UnderlineInputBorder(
//                 borderSide: BorderSide(color: Kolors.kRed, width: 0.5),
//               ),
//               disabledBorder: const UnderlineInputBorder(
//                 borderSide: BorderSide(color: Kolors.kGray, width: 0.5),
//               ),
//               enabledBorder: const UnderlineInputBorder(
//                 borderSide: BorderSide(color: Kolors.kGray, width: 0.5),
//               ),
//               border: InputBorder.none),
//           controller: controller,
//           cursorHeight: 25,
//           style: appStyle(12, Colors.black, FontWeight.normal),
//           onSubmitted: onSubmitted),
//     );
//   }
// }
