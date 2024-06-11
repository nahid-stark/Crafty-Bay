import 'package:crafty_bay/presentation/screens/complete_profile_screen.dart';
import 'package:crafty_bay/presentation/utility/app_colors.dart';
import 'package:crafty_bay/presentation/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email;

  const OtpVerificationScreen({super.key, required this.email});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _otpTEController = TextEditingController();
  RxInt resendOtpCodeTimerCounterValue = 120.obs;
  RxBool isOtpCodeExpired = false.obs;

  @override
  void initState() {
    super.initState();
    expireOtpCodeTimerController();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 70),
                  const AppLogo(),
                  const SizedBox(height: 28),
                  Text(
                    "Enter OTP Code",
                    style: textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "A 4 Digit OTP Code Has Been Sent",
                    style: textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 26),
                  _buildPinField(),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Get.off(() => const CompleteProfileScreen());
                    },
                    child: const Text("Next"),
                  ),
                  const SizedBox(height: 16),
                  Obx(
                    () => _buildResendCodeMessage(textTheme),
                  ),
                  Obx(
                    () => _buildResendCodeButton(textTheme),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResendCodeButton(TextTheme textTheme) {
    return TextButton(
      onPressed: isOtpCodeExpired.value
          ? () {
              resendOtpCodeTimerCounterValue.value = 120;
              expireOtpCodeTimerController();
              isOtpCodeExpired.value = false;
            }
          : null,
      child: Text(
        "Resend Code",
        style: textTheme.headlineSmall
            ?.copyWith(color: isOtpCodeExpired.value ? Colors.purple : Colors.blueGrey),
      ),
    );
  }

  Widget _buildResendCodeMessage(TextTheme textTheme) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "This code will expire in ",
            style: textTheme.headlineSmall,
          ),
          TextSpan(
            text: "${resendOtpCodeTimerCounterValue.value} s",
            style: textTheme.headlineSmall?.copyWith(color: AppColors.primaryColor),
          ),
        ],
      ),
    );
  }

  Widget _buildPinField() {
    return SizedBox(
      width: 250,
      child: PinCodeTextField(
        length: 4,
        keyboardType: TextInputType.number,
        obscureText: false,
        autoDisposeControllers: false,
        animationType: AnimationType.fade,
        showCursor: true,
        cursorColor: Colors.purple,
        cursorWidth: 3,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 50,
          fieldWidth: 50,
          activeFillColor: Colors.white,
          inactiveFillColor: Colors.transparent,
          selectedFillColor: Colors.white,
          inactiveColor: AppColors.primaryColor,
          selectedColor: Colors.red,
        ),
        animationDuration: const Duration(milliseconds: 300),
        enableActiveFill: true,
        controller: _otpTEController,
        appContext: context,
      ),
    );
  }

  Future<void> expireOtpCodeTimerController() async {
    while (resendOtpCodeTimerCounterValue > 0) {
      await Future.delayed(const Duration(seconds: 1));
      resendOtpCodeTimerCounterValue--;
    }
    isOtpCodeExpired.value = true;
  }

  @override
  void dispose() {
    _otpTEController.dispose();
    super.dispose();
  }
}
