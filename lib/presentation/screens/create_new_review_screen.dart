import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateNewReviewScreen extends StatefulWidget {
  const CreateNewReviewScreen({super.key});

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
    return Scaffold(
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
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("Submit"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
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
                Get.back();
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
