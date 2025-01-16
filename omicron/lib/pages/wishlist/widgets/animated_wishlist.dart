import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class AnimatedWishListBtn extends StatefulWidget {
  const AnimatedWishListBtn(
      {super.key,
      required this.productId,
      required this.isInWishList,
      required this.onTap});

  final int productId;
  final bool isInWishList;
  final Function() onTap;

  @override
  State<AnimatedWishListBtn> createState() => _AnimatedWishListBtnState();
}

class _AnimatedWishListBtnState extends State<AnimatedWishListBtn> {
  @override
  Widget build(BuildContext context) {
    {
      return LikeButton(
        size: 24,
        isLiked: widget.isInWishList,
        circleColor: const CircleColor(
          start: Color(0xFFFF5722),
          end: Color(0xFFFF5722),
        ),
        bubblesColor: const BubblesColor(
          dotPrimaryColor: Color(0xFFFF5722),
          dotSecondaryColor: Color(0xFFFF7043),
        ),
        likeBuilder: (bool isLiked) {
          return Icon(
            isLiked ? Icons.favorite : Icons.favorite_border,
            color: isLiked ? Colors.red : Colors.grey,
            size: 24,
          );
        },
        onTap: (isLiked) async {
          widget.onTap();
          return !isLiked;
        },
      );
    }
  }
}
