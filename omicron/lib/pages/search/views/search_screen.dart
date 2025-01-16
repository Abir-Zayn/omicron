import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:omicron/pages/products/widgets/staggered_tile_widget.dart';
import 'package:omicron/pages/search/controllers/search_notifier.dart';
import 'package:omicron/pages/wishlist/controllers/wishlist_notifier.dart';
import 'package:omicron/src/common/services/storage.dart';
import 'package:omicron/src/common/utils/appColors.dart';
import 'package:omicron/src/common/utils/app_strings.dart';
import 'package:omicron/src/widgets/app_style.dart';
import 'package:omicron/src/widgets/back_button.dart';
import 'package:omicron/src/widgets/email_textfield.dart';
import 'package:omicron/src/widgets/empty_screen_widget.dart';
import 'package:omicron/src/widgets/login_bottom_sheet.dart';
import 'package:omicron/src/widgets/reusable_text.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load the search history when the screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SearchNotifier>().loadSearchHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    //Check if the user is logged in
    String? accessToken = Storage().getString('accessToken');

    return Scaffold(
      //appBar -> Has a back button, a title, and a search bar
      appBar: AppBar(
        leading: AppBackButton(
          onTap: () {
            context.read<SearchNotifier>().clearResults();
            context.pop();
          },
        ),
        title: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().screenWidth * 0.24,
          ),
          child: ReusableText(
            text: AppStrings.appSearch,
            style: appStyle(24, AppColors.appDark, FontWeight.bold),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: Padding(
            padding: EdgeInsets.all(14.w),
            //Using the TextField widget to create a search bar
            child: EmailTextField(
              controller: _searchController,
              hintText: "Search for a product",
              radius: 20,
              prefixIcon: GestureDetector(
                  onTap: () {
                    //run the query
                    //as long as the search bar is not empty
                    if (_searchController.text.isNotEmpty) {
                      //call the search function from the search notifier
                      context
                          .read<SearchNotifier>()
                          .searchFunction(_searchController.text);
                    } else {}
                  },
                  child: const Icon(AntDesign.search1)),
            ),
          ),
        ),
      ),

      //SearchScreen is a StatefulWidget because it holds a TextEditingController for the search input and manages user interaction with the search field.
      //The search field is a TextField widget that allows users to input search queries.
      //A grid or list view likely displays the search results, using staggered_grid_view to create a staggered layout for visual appeal.
      //use a StaggeredTileWidget to display each product tile.(if there is products)
      //If no results are found, it might display an EmptyScreenWidget.
      //Provider.of<SearchNotifier>(context) allows SearchScreen to interact with the SearchNotifier to get loading status, search results, and error messages in real time.
      body: Consumer<SearchNotifier>(
        builder: (context, searchNotifier, child) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: ListView(
              children: [
                // When searched products are available
                if (searchNotifier.searchHistory.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(
                        text: "Search History",
                        style: appStyle(15, AppColors.appDark, FontWeight.w500),
                      ),

                      // Display the search history
                      SizedBox(
                        height: 10.h,
                      ),
                      ...searchNotifier.searchHistory.map((history) {
                        return GestureDetector(
                          onTap: () {
                            _searchController.text = history;
                            context
                                .read<SearchNotifier>()
                                .searchFunction(history);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.h),
                            child: Row(
                              children: [
                                Icon(
                                  AntDesign.search1,
                                  color: AppColors.appDark,
                                  size: 20.sp,
                                ),
                                SizedBox(width: 10.w),
                                ReusableText(
                                  text: history,
                                  style: appStyle(
                                      16, AppColors.appDark, FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),

                // When searched products are available
                if (searchNotifier.results.isNotEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ReusableText(
                        text: "Search Results",
                        style: appStyle(15, AppColors.appDark, FontWeight.w500),
                      ),
                      ReusableText(
                        text: searchNotifier.searchKey,
                        style: appStyle(15, AppColors.appDark, FontWeight.bold),
                      ),
                    ],
                  )
                else
                  const SizedBox.shrink(),

                SizedBox(
                  height: 10.h,
                ),

                searchNotifier.results.isNotEmpty
                    ? StaggeredGrid.count(
                        mainAxisSpacing: 8, //change to 4
                        crossAxisSpacing: 8, //change to 4
                        crossAxisCount: 4,
                        children: List.generate(searchNotifier.results.length,
                            (index) {
                          final double mainAxisCellCount =
                              (index % 2 == 0 ? 2.17 : 2.4);
                          final product = searchNotifier.results[index];
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
                                  context
                                      .read<WishlistNotifier>()
                                      .addRemoveWishList(product.id, () {});
                                }
                              },
                            ),
                          );
                        }),
                      )
                    : const EmptyScreenWidget()
              ],
            ),
          );
        },
      ),
    );
  }
}
