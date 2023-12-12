import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopee/common/utils/notifications.dart';
import 'package:shopee/feature/home/data/repositories/home_repository_impl.dart';
import 'package:shopee/feature/home/presentation/bloc/home_product_cubit.dart';
import 'package:shopee/feature/home/presentation/bloc/home_product_state.dart';
import 'package:shopee/feature/home/presentation/ui/home_page.dart';
import 'package:shopee/feature/pdp/data/repositories/pdp_repository_impl.dart';
import 'package:shopee/feature/pdp/presentation/bloc/product_details_cubit.dart';
import 'package:shopee/feature/pdp/presentation/bloc/product_details_state.dart';
import 'package:shopee/feature/pdp/presentation/ui/product_detail_page.dart';
import 'package:shopee/feature/plp/data/repositories/plp_repository_impl.dart';
import 'package:shopee/feature/plp/presentation/bloc/product_list_cubit.dart';
import 'package:shopee/feature/plp/presentation/bloc/product_list_state.dart';
import 'package:shopee/feature/plp/presentation/ui/product_listing_page.dart';
import 'common/colors/colors.dart';
import 'feature/splash/presentation/ui/splash_page.dart';
import 'feature/login/presentation/ui/login_page.dart';
import 'firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseNotifications().initNotification();
  FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
  FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: themeBackgroundColor,
      ),
      initialRoute: 'splash',
      routes: {
        'splash': (context) => const SplashPage(),
        'login': (context) => const LoginPage(),
        'home': (context) {
          return BlocProvider(
              create: (context) => HomeProductCubit(
                  HomeRepositoryImpl(), HomeProductInitialState()),
              child: const HomePage());
        },
        'plp': (context) {
          return BlocProvider(
            create: (context) => ProductListCubit(
                PLPRepositoryImpl(), ProductListInitialState()),
            child: const ProductListingPage(),
          );
        },
        'pdp': (context) {
          return BlocProvider(
              create: (context) => ProductDetailCubit(
                  PdpRepositoryImpl(), ProductDetailInitialState()),
              child: const ProductDetailPage());
        },
      },
    );
  }
}
