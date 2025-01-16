import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:omicron/pages/products/controllers/product_notfier.dart';
import 'package:omicron/pages/products/hooks/fetch_similar.dart';
import 'package:omicron/pages/products/widgets/staggered_tile_widget.dart';
import 'package:omicron/pages/wishlist/controllers/wishlist_notifier.dart';
import 'package:omicron/src/common/services/storage.dart';
import 'package:omicron/src/widgets/login_bottom_sheet.dart';
import 'package:provider/provider.dart';

class SimilarProducts extends HookWidget {
  const SimilarProducts({super.key});

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');
    final results =
        fetchSimilarProducts(context.watch<ProductNotfier>().product!.brand);
    final productlist = results.products;
    final isLoading = results.isLoading;
    final error = results.error;
    final refetch = results.refetch;

    //handle is loading
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    //handle error
    if (error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('An error occurred: $error'),
            ElevatedButton(
              onPressed: refetch,
              child: const Text('Try again'),
            ),
          ],
        ),
      );
    }

    //handle no data
    if (productlist.isEmpty) {
      return const Center(
        child: Text('No products found'),
      );
    }

    return Padding(
      padding: EdgeInsets.all(10.h),
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
                }else {
                  context.read<WishlistNotifier>().addRemoveWishList(product.id, refetch);
                }
              },
            ),
          );
        }), // *!Possible of getting error
      ),
    );
  }
}
