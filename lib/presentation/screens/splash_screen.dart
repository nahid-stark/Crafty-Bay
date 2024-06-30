import 'package:crafty_bay/presentation/screens/main_bottom_nav_bar_screen.dart';
import 'package:crafty_bay/presentation/state_holders/user_auth_controller.dart';
import 'package:crafty_bay/presentation/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 5));
    await UserAuthController.getUserToken();
    Get.offAll(() => const MainBottomNavBarScreen());
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          children: [
            Spacer(),
            AppLogo(),
            Spacer(),
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text("version 1.0.0"),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }
}