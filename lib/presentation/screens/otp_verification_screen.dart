import 'package:crafty_bay/data/network_caller/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:crafty_bay/presentation/screens/complete_profile_screen.dart';
import 'package:crafty_bay/presentation/state_holders/read_profile_controller.dart';
import 'package:crafty_bay/presentation/state_holders/verify_otp_controller.dart';
import 'package:crafty_bay/presentation/utility/app_colors.dart';
import 'package:crafty_bay/presentation/widgets/app_logo.dart';
import 'package:crafty_bay/presentation/widgets/centered_circular_progress_indicator.dart';
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
                    "A 4 Digit OTP Code Has Been Sent To",
                    style: textTheme.headlineSmall,
                  ),
                  Text(
                    widget.email,
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
                          if (readProfileController.inProgress) {
                            return const CenteredCircularProgressIndicator();
                          }
                          return ElevatedButton(
                            onPressed: () async {
                              final bool result =
                                  await verifyOtpController.verifyOtp(widget.email, _otpTEController.text);
                              if (result) {
                                await readProfileController.readProfile();
                                if (readProfileController.profileDataList.isNotEmpty) {
                                  Get.snackbar(
                                    "",
                                    "",
                                    titleText: const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 12),
                                      child: Text(
                                        "Authentication Success",
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 24,
                                        ),
                                      ),
                                    ),
                                    messageText: const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 12),
                                      child: Text(
                                        "All information Registered",
                                        style:
                                            TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                                      ),
                                    ),
                                    animationDuration: const Duration(milliseconds: 200),
                                    backgroundColor: Colors.black54,
                                    borderRadius: 4,
                                    margin: const EdgeInsets.only(top: 12, left: 4, right: 40),
                                    padding: const EdgeInsets.symmetric(vertical: 4),
                                    duration: const Duration(seconds: 1),
                                    snackPosition: SnackPosition.TOP,
                                    leftBarIndicatorColor: Colors.green,
                                  );
                                  Future.delayed(
                                    const Duration(milliseconds: 1500),
                                    () {
                                      Get.back();
                                    },
                                  );
                                } else {
                                  Get.snackbar(
                                    "",
                                    "",
                                    titleText: const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 12),
                                      child: Text(
                                        "Authentication Success",
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 24,
                                        ),
                                      ),
                                    ),
                                    messageText: const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 12),
                                      child: Text(
                                        "Need to Completer Profile Information",
                                        style:
                                            TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                                      ),
                                    ),
                                    animationDuration: const Duration(milliseconds: 500),
                                    backgroundColor: Colors.black54,
                                    borderRadius: 4,
                                    margin: const EdgeInsets.only(top: 12, left: 4, right: 40),
                                    padding: const EdgeInsets.symmetric(vertical: 4),
                                    duration: const Duration(seconds: 3),
                                    snackPosition: SnackPosition.TOP,
                                    leftBarIndicatorColor: Colors.green,
                                  );
                                  Get.off(() => const CompleteProfileScreen());
                                }
                              } else {
                                Get.snackbar(
                                  "",
                                  "",
                                  titleText: const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 12),
                                    child: Text(
                                      "OTP Not Sent",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
                                  messageText: const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 12),
                                    child: Text(
                                      "Your OTP may be wrong",
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                                    ),
                                  ),
                                  animationDuration: const Duration(milliseconds: 500),
                                  backgroundColor: Colors.black54,
                                  borderRadius: 4,
                                  margin: const EdgeInsets.only(top: 12, left: 4, right: 40),
                                  padding: const EdgeInsets.symmetric(vertical: 4),
                                  duration: const Duration(seconds: 3),
                                  snackPosition: SnackPosition.TOP,
                                  leftBarIndicatorColor: Colors.red,
                                );
                              }
                            },
                            child: const Text("Next"),
                          );
                        },
                      );
                    },
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
