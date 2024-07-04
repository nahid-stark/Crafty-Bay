import 'package:crafty_bay/data/models/create_review_model.dart';
import 'package:crafty_bay/presentation/state_holders/create_review_controller.dart';
import 'package:crafty_bay/presentation/widgets/centered_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateNewReviewScreen extends StatefulWidget {
  const CreateNewReviewScreen({super.key, required this.productId});

  final int productId;

  @override
  State<CreateNewReviewScreen> createState() => _CreateNewReviewScreenState();
}

class _CreateNewReviewScreenState extends State<CreateNewReviewScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _writeReviewTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back(result: false);
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            _appBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    children: [
                      _buildCreateReviewForm(),
                      const SizedBox(height: 18),
                      GetBuilder<CreateReviewController>(
                        builder: (createReviewController) {
                          if(createReviewController.inProgress) {
                            return const CenteredCircularProgressIndicator();
                          }
                          return ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                CreateReviewModel reviewModel = CreateReviewModel(
                                  description: _writeReviewTEController.text.trim(),
                                  productId: widget.productId,
                                );
                                createReviewController.createReview(reviewModel).then(
                                  (result) {
                                    if (result) {
                                      Get.snackbar(
                                        "",
                                        "",
                                        titleText: const Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 12),
                                          child: Text(
                                            "Review Added",
                                            style: TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
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
                                      Future.delayed(const Duration(milliseconds: 1300), (){Get.back(result: true);});
                                    } else {
                                      Get.snackbar(
                                        "",
                                        "",
                                        titleText: const Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 12),
                                          child: Text(
                                            "Need to Login First",
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
                            child: const Text("Submit"),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreateReviewForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _firstNameTEController,
            decoration: const InputDecoration(
              hintText: "First Name",
            ),
          ),
          const SizedBox(height: 18),
          TextFormField(
            controller: _lastNameTEController,
            decoration: const InputDecoration(
              hintText: "Last Name",
            ),
          ),
          const SizedBox(height: 18),
          TextFormField(
            controller: _writeReviewTEController,
            validator: (String? text) {
              if (text?.isEmpty ?? true) {
                return "Enter Your Review";
              } else {
                return null;
              }
            },
            maxLines: 8,
            decoration: const InputDecoration(
              hintText: "Write Review",
            ),
          ),
        ],
      ),
    );
  }

  Widget _appBar() {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 0.1),
          AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_outlined),
              onPressed: () {
                Get.back(result: false);
              },
            ),
            title: const Text("Create Review"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _writeReviewTEController.dispose();
    super.dispose();
  }
}
