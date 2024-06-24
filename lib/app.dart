import 'package:crafty_bay/controller_binder.dart';
import 'package:crafty_bay/presentation/screens/splash_screen.dart';
import 'package:crafty_bay/presentation/utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CraftyBay extends StatefulWidget {
  const CraftyBay({super.key});

  static GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  @override
  State<CraftyBay> createState() => _CraftyBayState();
}

class _CraftyBayState extends State<CraftyBay> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: AppColors.primaryColor));
    return GetMaterialApp(
      navigatorKey: CraftyBay.navigationKey,
      home: const SplashScreen(),
      initialBinding: ControllerBinder(),
      title: "Crafty Bay",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: AppColors.primaryColor,
        progressIndicatorTheme: _progressIndicatorTheme(),
        textTheme: _textTheme(),
        inputDecorationTheme: _inputDecorationTheme(),
        elevatedButtonTheme: _elevatedButtonTheme(),
        appBarTheme: _appBarTheme(),
        textButtonTheme: _textButtonTheme(),
      ),
    );
  }

  TextButtonThemeData _textButtonTheme() => TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryColor,
        ),
      );

  AppBarTheme _appBarTheme() => const AppBarTheme(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      );

  ProgressIndicatorThemeData _progressIndicatorTheme() => const ProgressIndicatorThemeData(
        color: AppColors.primaryColor,
      );

  ElevatedButtonThemeData _elevatedButtonTheme() => ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          fixedSize: const Size.fromWidth(double.maxFinite),
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
      );

  TextTheme _textTheme() => const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        headlineSmall: TextStyle(fontSize: 16, color: Colors.blueGrey),
      );

  InputDecorationTheme _inputDecorationTheme() => InputDecorationTheme(
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w400,
        ),
        border: _outlineInputBorder,
        focusedBorder: _outlineInputBorder,
        enabledBorder: _outlineInputBorder,
        errorBorder: _outlineInputBorder.copyWith(
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
      );

  final OutlineInputBorder _outlineInputBorder = const OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
  );
}
