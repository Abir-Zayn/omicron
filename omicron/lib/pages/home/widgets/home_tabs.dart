import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:omicron/pages/home/controllers/home_tab_notifier.dart';
import 'package:omicron/pages/home/views/home_screen.dart';
import 'package:omicron/src/common/utils/appColors.dart';
import 'package:omicron/src/widgets/app_style.dart';
import 'package:omicron/src/widgets/tab_widget.dart';
import 'package:provider/provider.dart';

class HomeTabs extends StatelessWidget {
  const HomeTabs({super.key, required TabController tabController})
      : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeTabNotifier>(
      builder: (context, notifier, child) {
        if (notifier.errorMessage != null) {
          return Center(child: Text('Error: ${notifier.errorMessage}'));
        }

        return SizedBox(
          height: 22.h,
          child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Colors.grey,
              ),
              labelPadding: EdgeInsets.zero,
              labelColor: AppColors.appWhite,
              dividerColor: Colors.transparent,
              tabAlignment: TabAlignment.start,
              isScrollable: true,
              labelStyle: appStyle(12, Colors.black, FontWeight.w500),
              unselectedLabelStyle: appStyle(12, Colors.black, FontWeight.w300),
              tabs: List.generate(
                homeTabs.length,
                (index) => Tab(
                  child: TabWidget(
                    text: homeTabs[index],
                  ),
                ),
              )),
        );
      },
    );
  }
}
