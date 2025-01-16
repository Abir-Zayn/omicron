import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:omicron/pages/cart/views/cart_screen.dart';
import 'package:omicron/pages/entrypoint/views/controllers/bottom_tab_notifier.dart';
import 'package:omicron/pages/home/views/home_screen.dart';
import 'package:omicron/pages/profile/views/profile_screen.dart';
import 'package:omicron/pages/wishlist/views/wishlist_screen.dart';
import 'package:omicron/src/common/utils/appColors.dart';
import 'package:omicron/src/widgets/app_style.dart';
import 'package:provider/provider.dart';

class AppEntryPoint extends StatelessWidget {
  AppEntryPoint({super.key});

  List<Widget> pageList = [
    const HomeScreen(),
    const WishlistScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<TabIndexNotifier>(
      builder: (context, tabIndexNotifier, child) {
        return Scaffold(
          body: Stack(
            children: [
              pageList[tabIndexNotifier.index],
              Padding(
                padding: const EdgeInsets.all( 10),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(canvasColor: Colors.transparent),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)
                      ),
                      child: Container(
                        color: AppColors.appPrimary,
                        padding: const EdgeInsets.all(2),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: BottomNavigationBar(
                            selectedFontSize: 12,
                            elevation: 0, //change to 0
                            showSelectedLabels: true, //change to true
                            selectedLabelStyle:
                                appStyle(13, Colors.white, FontWeight.w500),
                            showUnselectedLabels: false,
                            selectedItemColor: AppColors.appWhite,
                            unselectedItemColor: AppColors.appOffWhite,
                            currentIndex: tabIndexNotifier.index,
                            unselectedIconTheme:
                                const IconThemeData(color: AppColors.appOffWhite),
                            onTap: (index) {
                              tabIndexNotifier.setIndex(index);
                            },
                            items: [
                              //Toggle to Home Screen
                              BottomNavigationBarItem(
                                  icon: tabIndexNotifier.index == 0
                                      ? const Icon(AntDesign.home,
                                          color: Colors.white, size: 24)
                                      : const Icon(AntDesign.home,
                                          color: AppColors.appOffWhite, size: 24),
                                  label: 'Home'),
                
                              //Toggle to Wishlist Screen
                              BottomNavigationBarItem(
                                  icon: tabIndexNotifier.index == 1
                                      ? const Icon(Ionicons.heart_outline,
                                          color: Colors.white, size: 24)
                                      : const Icon(Ionicons.heart_outline,
                                          color: AppColors.appOffWhite, size: 24),
                                  label: 'Wishlist'),
                
                              //Toggle to Cart Screen with notification badge(counter)
                              BottomNavigationBarItem(
                                  icon: tabIndexNotifier.index == 2
                                      ? const Badge(
                                          label: Text('9'),
                                          child: Icon(
                                              MaterialCommunityIcons
                                                  .shopping_outline,
                                              color: Colors.white,
                                              size: 24),
                                        )
                                      : const Badge(
                                          label: Text('9'),
                                          child: Icon(
                                              MaterialCommunityIcons
                                                  .shopping_outline,
                                              color: AppColors.appOffWhite,
                                              size: 24),
                                        ),
                                  label: 'Cart'),
                
                              BottomNavigationBarItem(
                                  icon: tabIndexNotifier.index == 3
                                      ? const Icon(
                                          MaterialCommunityIcons.face_man_outline,
                                          color: Colors.white,
                                          size: 24)
                                      : const Icon(
                                          MaterialCommunityIcons.face_man_outline,
                                          color: AppColors.appOffWhite,
                                          size: 24),
                                  label: 'Profile'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
