import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:omicron/pages/home/controllers/home_tab_notifier.dart';
import 'package:omicron/pages/home/widgets/categories_list.dart';
// import 'package:omicron/pages/home/widgets/category_tab.dart';
import 'package:omicron/pages/home/widgets/custom_app_bar.dart';
import 'package:omicron/pages/home/widgets/home_headers.dart';
import 'package:omicron/pages/home/widgets/home_slider.dart';
import 'package:omicron/pages/home/widgets/home_tabs.dart';
import 'package:omicron/pages/products/widgets/explore_products.dart';
import 'package:omicron/src/common/utils/appColors.dart';
import 'package:omicron/src/widgets/flash_message.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final TabController _tabController;
  bool isLoading = false;
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: homeTabs.length, vsync: this);
    _tabController.addListener(_handleSelection);

    // Defer the initial data fetch until after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchDataForTab(_currentTabIndex);
    });
  }

  void _handleSelection() {
    // final controller = Provider.of<HomeTabNotifier>(context, listen: false);

    if (_tabController.indexIsChanging) {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
      // controller.setIndex(homeTabs[_currentTabIndex]);
      _fetchDataForTab(_currentTabIndex);
    }
  }

  Future<void> _fetchDataForTab(int index) async {
    final controller = Provider.of<HomeTabNotifier>(context, listen: false);
    setState(() {
      isLoading = true;
    });
    try {
      await controller.fetchDataForTab(index);
    } catch (e) {
      // Handle errors if needed
      //custom snackbar/FlashMessageScreen
      var snackBar = SnackBar(
        content: FlashMessageScreen(
          text: "Error: $e",
          messgaeType: MessageType.error,
          onClose: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleSelection);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: CustomAppBar(),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          children: [
            SizedBox(
              height: 20.h,
            ),
            const HomeSlider(),
            SizedBox(
              height: 15.h,
            ),
            const HomeHeader(),
            SizedBox(
              height: 10.h,
            ),
            const HomeCategoriesList(),
            // const HomeCategoriesList(),
            SizedBox(
              height: 10.h,
            ),
            HomeTabs(
              tabController: _tabController,
            ),
            SizedBox(
              height: 10.h,
            ),

            Consumer<HomeTabNotifier>(
              builder: (context, notifier, child) {
                if (notifier.isLoading) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 60.h),
                    child: const Center(
                        child: CircularProgressIndicator(
                      backgroundColor: AppColors.appDark,
                      strokeWidth: 8,
                      color: AppColors.appPrimary,
                    )),
                  );
                }

                if (notifier.errorMessage != null) {
                  return Center(child: Text('Error: ${notifier.errorMessage}'));
                }

                return const ExploreProducts();
              },
            ),

            SizedBox(
              height: 150.h,
            ),
          ],
        ));
  }
}

List<String> homeTabs = [
  'All',
  'Popular',
  'Deals',
  'Men',
  'Women',
  'kids',
];
