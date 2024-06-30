import 'package:crafty_bay/data/network_caller/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:crafty_bay/presentation/screens/complete_profile_screen.dart';
import 'package:crafty_bay/presentation/screens/main_bottom_nav_bar_screen.dart';
import 'package:crafty_bay/presentation/state_holders/read_profile_controller.dart';
import 'package:crafty_bay/presentation/state_holders/verify_otp_controller.dart';
import 'package:crafty_bay/presentation/utility/app_colors.dart';
import 'package:crafty_bay/presentation/widgets/app_logo.dart';
import 'package:crafty_bay/presentation/widgets/centered_circular_progress_indicator.dart';
import 'package:crafty_bay/presentation/widgets/snack_message.dart';
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
                  GetBuilder<VerifyOtpController>(
                    builder: (verifyOtpController) {
                      if (verifyOtpController.inProgress) {
                        return const CenteredCircularProgressIndicator();
                      }
                      return GetBuilder<ReadProfileController>(
                        builder: (readProfileController) {
                          return ElevatedButton(
                            onPressed: () async {
                              final bool result =
                                  await verifyOtpController.verifyOtp(widget.email, _otpTEController.text);
                              if (result) {
                                final bool result2 = await readProfileController.readProfile();
                                if (result2) {
                                  print("Profile has data");
                                  //Get.off(() => const MainBottomNavBarScreen());
                                } else {
                                  print("Profile has no such data. Going for complete Profile");
                                  //Get.off(() => const CompleteProfileScreen());
                                }
                              } else {
                                if (mounted) {
                                  print(verifyOtpController.errorMessage);
                                  //showSnackMessage(context, verifyOtpController.errorMessage);
                                }
                              }
                            },
                            child: const Text("Next"),
                          );
                        },
                      );
                    },
                  ),
                  ElevatedButton(
                    onPressed: (){
                      NetworkCaller.getRequest(url: Urls.readProfile);
                    },
                    child: Text("hit"),
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
              NetworkCaller.getRequest(url: Urls.verifyEmail(widget.email));
            }
          : null,
      child: Text(
        "Resend Code",
        style: textTheme.headlineSmall?.copyWith(color: isOtpCodeExpired.value ? Colors.purple : Colors.blueGrey),
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
