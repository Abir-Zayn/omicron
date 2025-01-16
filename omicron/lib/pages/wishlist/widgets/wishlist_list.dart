import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:omicron/pages/home/controllers/home_tab_notifier.dart';
import 'package:omicron/pages/products/widgets/staggered_tile_widget.dart';
import 'package:omicron/pages/wishlist/controllers/wishlist_notifier.dart';
import 'package:omicron/pages/wishlist/hooks/fetch_wishlist.dart';
import 'package:omicron/src/common/services/storage.dart';
import 'package:omicron/src/widgets/empty_screen_widget.dart';
import 'package:omicron/src/widgets/login_bottom_sheet.dart';
import 'package:provider/provider.dart';

class WishlistWidget extends HookWidget {
  const WishlistWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');
    final results = fetchWishList();
    final productlist = results.products;
    final isLoading = results.isLoading;
    final error = results.error;
    final refetch = results.refetch;

    context.read<HomeTabNotifier>().setRefetch(refetch);

    if (isLoading) {
      // return circle progress indicator
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (error != null) {
      return Center(
        child: Text.rich(
          TextSpan(
            text: 'Error: ',
            style: TextStyle(
              color: Colors.red,
              fontSize: 16.sp,
            ),
            children: [
              TextSpan(
                text: error.toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return productlist.isEmpty
        ? const EmptyScreenWidget()
        : Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 6.h,
            ),
            child: StaggeredGrid.count(
              mainAxisSpacing: 8, //change to 4
              crossAxisSpacing: 8, //change to 4
              crossAxisCount: 4,
              children: List.generate(productlist.length, (index) {
                final double mainAxisCellCount = (index % 2 == 0 ? 2.17 : 2.4);
                final product = productlist[index];
                return StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: mainAxisCellCount,
                  child: StaggeredTileWidget(
                    index: index,
                    product: product,
                    ontap: () {
                      // Check if the user is logged in
                      //If the user is not logged in, show the login bottom sheet
                      if (accessToken == null) {
                        loginBottomSheet(context);
                      } else {
                        context.read<WishlistNotifier>().addRemoveWishList(product.id, refetch);
                      }
                      //  Navigate to product details page
                      // Pass the product id to the product details page
                    },
                  ),
                );
              }), // *!Possible of getting error
            ),
          );
  }
}
