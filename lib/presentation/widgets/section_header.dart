import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String header;
  final VoidCallback onTapSeeAll;

  const SectionHeader({super.key, required this.header, required this.onTapSeeAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          header,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        TextButton(
          onPressed: onTapSeeAll,
          child: const Text(
            "See All",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
