import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:omicron/pages/onboarding/controllers/onboarding_notifier.dart';
import 'package:omicron/pages/onboarding/widgets/onboarding_page_one.dart';
import 'package:omicron/pages/onboarding/widgets/onboarding_page_two.dart';
import 'package:omicron/pages/onboarding/widgets/welcome_screen.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:provider/provider.dart';

/// The main OnboardingScreen widget which manages the onboarding flow.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  /// Controller to manage and listen to page changes in PageView.
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    // Initialize the PageController with the currently selected page from OnboardingNotifier.
    _pageController = PageController(
      initialPage: context.read<OnboardingNotifier>().selectedPage,
    );
  }

  @override
  void dispose() {
    // Dispose of the PageController when the widget is removed from the widget tree.
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// PageView that holds the onboarding pages.
          PageView(
            controller: _pageController,
            // Callback when the page is changed via swipe or programmatically.
            onPageChanged: (page) {
              // Update the selectedPage in OnboardingNotifier.
              context.read<OnboardingNotifier>().selectedPage = page;
            },
            physics: const BouncingScrollPhysics(), // Adds a bouncing effect at the edges.
            pageSnapping: true, // Ensures pages snap into place after a swipe.
            children: [
              // Iterate through the number of onboarding pages and create each with an animation.
              for (int i = 0; i < 3; i++)
                AnimatedBuilder(
                  animation: _pageController,
                  builder: (context, child) {
                    double value = 1.0;

                    // Check if the PageController has dimensions to calculate the scale.
                    if (_pageController.position.haveDimensions) {
                      // Calculate the difference between the current page and the target page.
                      value = _pageController.page! - i;
                      // Apply a scaling factor based on the page position.
                      value = (1 - (value.abs() * 0.5)).clamp(0.0, 1.0);
                    }

                    return Transform.scale(
                      scale: Curves.easeOut.transform(value), // Apply easing to the scale.
                      child: i == 0
                          ? const OnboardingPageOne() // First onboarding page.
                          : i == 1
                              ? const OnboardingPageTwo() // Second onboarding page.
                              : const WelcomeScreen(), // Welcome screen after onboarding.
                    );
                  },
                ),
            ],
          ),

          /// Navigation controls (arrows and dots) positioned at the bottom.
          // Only display the navigation controls if the current page is not the last page (index 2).
          context.watch<OnboardingNotifier>().selectedPage != 2
              ? Positioned(
                  bottom: 50.h, // Position from the bottom using ScreenUtil for responsiveness.
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w), // Horizontal padding.
                    width: ScreenUtil().screenWidth, // Full screen width.
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space out the children.
                      crossAxisAlignment: CrossAxisAlignment.center, // Center vertically.
                      children: [
                        /// Left Arrow Icon to navigate to the previous page.
                        GestureDetector(
                          onTap: () {
                            // Animate to the previous page when tapped.
                            _pageController.animateToPage(
                              context.read<OnboardingNotifier>().selectedPage - 1,
                              duration: const Duration(milliseconds: 300), // Duration of the animation.
                              curve: Curves.easeIn, // Easing curve for the animation.
                            );
                          },
                          child: Icon(
                            AntDesign.leftcircleo, // Left arrow icon.
                            color: Colors.black, // Icon color.
                            size: 30.sp, // Icon size responsive to screen size.
                          ),
                        ),

                        /// Dots Indicator to show the current page.
                        SizedBox(
                          width: ScreenUtil().screenWidth * 0.7, // 70% of screen width.
                          height: 10.h, // Fixed height using ScreenUtil.
                          child: PageViewDotIndicator(
                            currentItem: context.watch<OnboardingNotifier>().selectedPage, // Current active page.
                            count: 3, // Total number of dots/pages.
                            unselectedColor: Colors.grey.shade400, // Color of unselected dots.
                            selectedColor: Colors.black, // Color of the selected dot.
                            duration: const Duration(milliseconds: 300), // Duration for the dot animation.
                            onItemClicked: (index) {
                              // Animate to the selected page when a dot is clicked.
                              _pageController.animateToPage(
                                index,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn,
                              );
                            },
                          ),
                        ),

                        /// Right Arrow Icon to navigate to the next page.
                        GestureDetector(
                          onTap: () {
                            // Animate to the next page when tapped.
                            _pageController.animateToPage(
                              context.read<OnboardingNotifier>().selectedPage + 1,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
                          },
                          child: Icon(
                            AntDesign.rightcircleo, // Right arrow icon.
                            color: Colors.black, // Icon color.
                            size: 30.sp, // Icon size responsive to screen size.
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : const SizedBox.shrink(), // Hide navigation controls on the last page.
        ],
      ),
    );
  }
}
