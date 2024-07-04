import 'package:crafty_bay/presentation/utility/assets_path.dart';
import 'package:flutter/material.dart';

class ReviewScreenItem extends StatefulWidget {
  const ReviewScreenItem({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.review,
  });

  final String firstName;
  final String lastName;
  final String review;

  @override
  State<ReviewScreenItem> createState() => _ReviewScreenItemState();
}

class _ReviewScreenItemState extends State<ReviewScreenItem> {
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
        Text(
          "${widget.firstName} ${widget.lastName}",
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildReviewSection() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        widget.review,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black54,
        ),
        softWrap: true,
      ),
    );
  }
}
