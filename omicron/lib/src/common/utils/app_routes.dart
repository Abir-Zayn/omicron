import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:omicron/pages/auth/views/login_screen.dart';
import 'package:omicron/pages/auth/views/signup_screen.dart';
import 'package:omicron/pages/categories/views/categories_screen.dart';
import 'package:omicron/pages/categories/views/category_screen.dart';
import 'package:omicron/pages/checkout/views/checkout_screen.dart';
import 'package:omicron/pages/notifications/views/notification_screen.dart';
import 'package:omicron/pages/products/views/product_screen.dart';
import 'package:omicron/pages/profile/widget/orders_screen.dart';
import 'package:omicron/pages/profile/widget/policy_screen.dart';
import 'package:omicron/pages/profile/widget/shipping_address.dart';
import 'package:omicron/pages/search/views/search_screen.dart';
import 'package:omicron/pages/splash_screen/splashscreen_page.dart';
import 'package:omicron/pages/entrypoint/views/entrypoint.dart';
import '../../../pages/onboarding/views/onboarding_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final GoRouter _router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => AppEntryPoint(),
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) => const SearchScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/notifications',
      builder: (context, state) => const NotificationScreen(),
    ),
    GoRoute(
      path: '/categories',
      builder: (context, state) => const CategoriesScreen(),
    ),
    GoRoute(
      path: '/category',
      builder: (context, state) => const CategoryScreen(),
    ),
    GoRoute(
        path: '/product/:id',
        builder: (BuildContext context, GoRouterState state) {
          final productId = state.pathParameters['id'];
          return ProductScreen(productId: productId.toString());
        }),
    GoRoute(
      path: '/addresses',
      builder: (context, state) => const ShippingAddress(),
    ),
    GoRoute(
      path: '/policy',
      builder: (context, state) => const PolicyScreen(),
    ),
    GoRoute(
      path: '/orders',
      builder: (context, state) => const OrdersScreen(),
    ),
    GoRoute(path: '/signUp', builder: (context, state) => const SignupScreen()),
    GoRoute(
      path: '/checkout',
      builder: (context, state) => const CheckoutScreen(),
    )
  ],
);

GoRouter get router => _router;
