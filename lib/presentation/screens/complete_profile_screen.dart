import 'package:crafty_bay/data/models/complete_profile_model.dart';
import 'package:crafty_bay/presentation/state_holders/complete_profile_controller.dart';
import 'package:crafty_bay/presentation/state_holders/user_auth_controller.dart';
import 'package:crafty_bay/presentation/widgets/app_logo.dart';
import 'package:crafty_bay/presentation/widgets/centered_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _cityTEController = TextEditingController();
  final TextEditingController _shippingAddressTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return PopScope(
      canPop: false,
      onPopInvoked: (_) {
        Get.snackbar(
          "",
          "",
          titleText: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              "Complete Your Account Information",
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w600,
                fontSize: 17,
              ),
            ),
          ),
          animationDuration: const Duration(milliseconds: 500),
          backgroundColor: Colors.black54,
          borderRadius: 4,
          margin: const EdgeInsets.only(top: 12, left: 4, right: 40, bottom: 0),
          padding: const EdgeInsets.only(top: 16, bottom: 0),
          duration: const Duration(seconds: 3),
          snackPosition: SnackPosition.TOP,
          leftBarIndicatorColor: Colors.red,
          barBlur: 2,
        );
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: Column(
                  children: [
                    const AppLogo(),
                    const SizedBox(height: 8),
                    Text(
                      "Complete Profile",
                      style: textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Get started with us with your details",
                      style: textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 12),
                    _buildCompleteProfileForm(),
                    const SizedBox(height: 16),
                    GetBuilder<CompleteProfileController>(builder: (completeProfileController) {
                      if (completeProfileController.inProgress) {
                        return const CenteredCircularProgressIndicator();
                      }
                      return ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            completeProfileController
                                .completeProfile(
                              CompleteProfileModel(
                                firstName: _firstNameTEController.text.trim(),
                                lastName: _lastNameTEController.text.trim(),
                                mobile: _mobileTEController.text.trim(),
                                city: _cityTEController.text.trim(),
                                shippingAddress: _shippingAddressTEController.text.trim(),
                              ),
                            )
                                .then(
                              (result) {
                                if (result) {
                                  Get.snackbar(
                                    "",
                                    "",
                                    titleText: const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 12),
                                      child: Text(
                                        "Profile Update Successful",
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                    animationDuration: const Duration(milliseconds: 100),
                                    backgroundColor: Colors.black54,
                                    borderRadius: 4,
                                    margin: const EdgeInsets.only(top: 12, left: 4, right: 40, bottom: 0),
                                    padding: const EdgeInsets.only(top: 16, bottom: 0),
                                    duration: const Duration(seconds: 1),
                                    snackPosition: SnackPosition.TOP,
                                    leftBarIndicatorColor: Colors.green,
                                    barBlur: 2,
                                  );
                                  Future.delayed(
                                    const Duration(milliseconds: 1300),
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
                                        "Something Wrong. Try Again",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    animationDuration: const Duration(milliseconds: 500),
                                    backgroundColor: Colors.black54,
                                    borderRadius: 4,
                                    margin: const EdgeInsets.only(top: 12, left: 4, right: 40, bottom: 0),
                                    padding: const EdgeInsets.only(top: 16, bottom: 0),
                                    duration: const Duration(seconds: 3),
                                    snackPosition: SnackPosition.TOP,
                                    leftBarIndicatorColor: Colors.red,
                                    barBlur: 2,
                                  );
                                }
                              },
                            );
                          }
                        },
                        child: const Text("Complete"),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCompleteProfileForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _firstNameTEController,
            decoration: const InputDecoration(
              hintText: "First Name",
            ),
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "Enter Your First Name";
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _lastNameTEController,
            decoration: const InputDecoration(
              hintText: "Last Name",
            ),
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "Enter Your Lasr Name";
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _mobileTEController,
            keyboardType: TextInputType.phone,
            maxLength: 11,
            decoration: const InputDecoration(
              hintText: "Mobile",
            ),
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "Enter Your Mobile Number";
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _cityTEController,
            decoration: const InputDecoration(
              hintText: "City",
            ),
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "Enter Your City";
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _shippingAddressTEController,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: "Shipping Address",
            ),
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "Enter Your Shipping Address";
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _cityTEController.dispose();
    _shippingAddressTEController.dispose();
    super.dispose();
  }
}
