import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:omicron/pages/categories/controllers/category_notifier.dart';
import 'package:omicron/pages/categories/hook/fetch_products_by_category.dart';
import 'package:omicron/pages/products/widgets/staggered_tile_widget.dart';
import 'package:omicron/pages/wishlist/controllers/wishlist_notifier.dart';
import 'package:omicron/src/common/services/storage.dart';
import 'package:omicron/src/widgets/login_bottom_sheet.dart';
import 'package:omicron/src/widgets/shimmers/list_shimmer.dart';
import 'package:provider/provider.dart';

class ProductScreenByCategory extends HookWidget {
  const ProductScreenByCategory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');
    final categoryNotifier = context.watch<CategoryNotifier>();
    final results = fetchProductsViaBrand(categoryNotifier.id);

    if (results.error != null) {
      return Center(
        child: Text.rich(
          TextSpan(
            text: 'An error occurred: ',
            children: [
              TextSpan(
                text: results.error.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (results.isLoading) {
      return const Scaffold(body: ListShimmer());
    }

    if (results.products.isEmpty) {
      return const Center(
        child: Text('No products found for this brand'),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.h),
      child: StaggeredGrid.count(
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        crossAxisCount: 4,
        children: List.generate(
          results.products.length,
          (index) {
            final double mainAxisCellCount = (index % 2 == 0 ? 2.17 : 2.4);
            final product = results.products[index];
            return StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: mainAxisCellCount,
              child: StaggeredTileWidget(
                index: index,
                product: product,
                ontap: () {
                  if (accessToken == null) {
                    loginBottomSheet(context);
                  } else {
                    context
                        .read<WishlistNotifier>()
                        .addRemoveWishList(product.id, () {});
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
