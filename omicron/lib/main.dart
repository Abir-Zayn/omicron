import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:omicron/pages/auth/controllers/auth_notifier.dart';
import 'package:omicron/pages/auth/controllers/password_notifier.dart';
import 'package:omicron/pages/cart/controllers/cart_notifier.dart';
import 'package:omicron/pages/categories/controllers/category_notifier.dart';
import 'package:omicron/pages/entrypoint/views/controllers/bottom_tab_notifier.dart';
import 'package:omicron/pages/home/controllers/home_tab_notifier.dart';
import 'package:omicron/pages/onboarding/controllers/onboarding_notifier.dart';
import 'package:omicron/pages/products/controllers/color_sizes_model.notifier.dart';
import 'package:omicron/pages/products/controllers/product_notfier.dart';
import 'package:omicron/pages/search/controllers/search_notifier.dart';
import 'package:omicron/pages/splash_screen/splashscreen_page.dart';
import 'package:omicron/pages/wishlist/controllers/wishlist_notifier.dart';
import 'package:omicron/src/common/utils/app_routes.dart';
import 'package:omicron/src/common/utils/environment.dart';
import 'package:provider/provider.dart';

void main() async {
  //Ensuring Flutter binding is initialized before running the app
  WidgetsFlutterBinding.ensureInitialized();

  //load the correct enviroment
  await dotenv.load(fileName: Environment.fileName);

  //GetStorage, a lightweight persistent storage library for Flutter.
  //This is used to store data locally across sessions (like shared preferences).
  await GetStorage.init();
  runApp(MultiProvider(
    providers: [
      //OnboardingNotifier is a custom class that extends ChangeNotifier
      ChangeNotifierProvider(create: (_) => OnboardingNotifier()),
      //TabIndexNotifier is a custom class that extends ChangeNotifier
      ChangeNotifierProvider(create: (_) => TabIndexNotifier()),
      ChangeNotifierProvider(create: (_) => CategoryNotifier()),
      ChangeNotifierProvider(create: (_) => HomeTabNotifier()),
      ChangeNotifierProvider(create: (_) => ProductNotfier()),
      ChangeNotifierProvider(create: (_) => ColorSizeModelNotifier()),
      ChangeNotifierProvider(create: (_) => PasswordNotifier()),
      ChangeNotifierProvider(create: (_) => AuthNotifier()),
      ChangeNotifierProvider(create: (_) => SearchNotifier()),
      ChangeNotifierProvider(create: (_) => WishlistNotifier()),
      ChangeNotifierProvider(create: (_) => CartNotifier()),
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    //Some of system settings mainly responsible for the top app bar
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white, // Set the color of the status bar
      statusBarIconBrightness: Brightness.dark, // For Android: use dark icons
      statusBarBrightness: Brightness.light, // For iOS: use light icons
    ));

    
  
    //responsive ScreenSize design
    Size screensize = MediaQuery.of(context).size;
    return ScreenUtilInit(
      designSize: screensize,
      minTextAdapt: true,
      splitScreenMode: false,
      useInheritedMediaQuery: true,
      builder: (_, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              colorScheme: ColorScheme.fromSwatch().copyWith(
                primary: Colors.blue,
                secondary: Colors.blueAccent,
              ),
              useMaterial3: true),

          //AppRoutes is a custom class that holds all the routes in the app
          routerConfig: router,
        );
      },
      child: const SplashScreen(),
    );
  }
}
