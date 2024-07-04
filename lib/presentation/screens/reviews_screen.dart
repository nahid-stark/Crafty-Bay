import 'package:crafty_bay/presentation/screens/create_new_review_screen.dart';
import 'package:crafty_bay/presentation/state_holders/review_controller.dart';
import 'package:crafty_bay/presentation/utility/app_colors.dart';
import 'package:crafty_bay/presentation/widgets/centered_circular_progress_indicator.dart';
import 'package:crafty_bay/presentation/widgets/review_screen_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({
    super.key,
    required this.productId,
  });

  final int productId;

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<ReviewController>().getReviewList(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => Get.find<ReviewController>().getReviewList(widget.productId),
        child: Column(
          children: [
            _appBar(),
            GetBuilder<ReviewController>(
              builder: (reviewController) {
                if (reviewController.inProgress) {
                  return SizedBox(
                    height: screenHeight - 145.1,
                    child: const CenteredCircularProgressIndicator(),
                  );
                }
                if (reviewController.reviewList.isEmpty) {
                  return SizedBox(
                    height: screenHeight - 156.1,
                    child: const Center(
                      child: Text(
                        "No Reviews",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 32,
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                    ),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: reviewController.reviewList.length,
                    itemBuilder: (context, index) {
                      return ReviewScreenItem(
                        firstName: reviewController.reviewList[index].profileData?.firstName ?? "",
                        lastName: reviewController.reviewList[index].profileData?.lastName ?? "",
                        review: reviewController.reviewList[index].description ?? "",
                      );
                    },
                  ),
                );
              },
            ),
            _buildQuantityAndAddButtonWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantityAndAddButtonWidget() {
    return GetBuilder<ReviewController>(
      builder: (reviewController) {
        if (reviewController.inProgress) {
          return const CenteredCircularProgressIndicator();
        }
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.15),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Reviews (${reviewController.reviewList.length})",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black54,
                ),
              ),
              FloatingActionButton(
                shape: const CircleBorder(),
                backgroundColor: AppColors.primaryColor,
                onPressed: () async {
                  bool result = await Get.to(() => CreateNewReviewScreen(productId: widget.productId));
                  if(result) {
                    Get.find<ReviewController>().getReviewList(widget.productId);
                  }
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ],
          ),
        );
      },
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
            title: const Text("Reviews"),
          ),
        ],
      ),
    );
  }
}
