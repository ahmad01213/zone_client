import 'package:arkan/Pages/HomeScreen.dart';
import 'package:arkan/Pages/SplashScreen.dart';
import 'package:arkan/Pages/navigationPage.dart';
import 'package:arkan/Providers/AddressesProvider.dart';
import 'package:arkan/Providers/CheckoutProvider.dart';
import 'package:arkan/Providers/FieldProvider.dart';
import 'package:arkan/Providers/FoodProvider.dart';
import 'package:arkan/Providers/MarketProvider.dart';
import 'package:arkan/Providers/OrderProvider.dart';
import 'package:arkan/Providers/UserProvider.dart';
import 'package:arkan/helpers/helpers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Providers/HomeProvider.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp( EasyLocalization(
      supportedLocales: [Locale('ar'), Locale('en')],
      path:
      'imgs/translations', // <-- change the path of the translation files
      fallbackLocale: Locale('ar', ''),
      child: MyApp()),);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.locale = Locale('ar');
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
            create: (context) => UserProvider()),
        ChangeNotifierProvider<HomeProvider>(
            create: (context) => HomeProvider()),
        ChangeNotifierProvider<MarketProvider>(
            create: (context) => MarketProvider()),
        ChangeNotifierProvider<FieldProvider>(
            create: (context) => FieldProvider()),
        ChangeNotifierProvider<FoodProvider>(
            create: (context) => FoodProvider()),
        ChangeNotifierProvider<AddressProvider>(
            create: (context) => AddressProvider()),
        ChangeNotifierProvider<CheckOutProvider>(
            create: (context) => CheckOutProvider()),
        ChangeNotifierProvider<OrderProvider>(
            create: (context) => OrderProvider()),
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        debugShowCheckedModeBanner: false,
        locale: context.locale,
        title: 'زون',  theme: ThemeData(
         primaryColor: mainColor,
          fontFamily: "default",
        primaryTextTheme: TextTheme(
            title: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500
            )
        ),

        primaryIconTheme: const IconThemeData.fallback().copyWith(
          color: Colors.black,
        ),
          accentColor: mainColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashScreen(),
      ),
    );
  }
}

