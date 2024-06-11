import 'package:crafty_bay/presentation/utility/assets_path.dart';
import 'package:flutter/material.dart';

class ReviewScreenItem extends StatelessWidget {
  const ReviewScreenItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 16,
        ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
          ),
        ),
        child: Column(
          children: [
            _buildAvatarAndName(),
            _buildReviewSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarAndName() {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey.shade200,
          child: Image.asset(
            AssetsPath.userProfileIcon,
            height: 25,
            width: 25,
          ),
        ),
        const SizedBox(width: 10),
        const Text(
          "Rabbil Hasan",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildReviewSection() {
    return const Padding(
      padding: EdgeInsets.all(8),
      child: Text(
        "Tesla's batteries are a cornerstone of its energy storage and electric vehicle (EV) technology, known for their innovation, efficiency, and performance.",
        style: TextStyle(
          fontSize: 14,
          color: Colors.black54,
        ),
        softWrap: true,
      ),
    );
  }
}
