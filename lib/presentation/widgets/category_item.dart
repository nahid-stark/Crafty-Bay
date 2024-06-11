import 'package:crafty_bay/presentation/screens/product_list_screen.dart';
import 'package:crafty_bay/presentation/utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const ProductListScreen(categoryName: "Electronics"));
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              Icons.desktop_mac_outlined,
              color: AppColors.primaryColor.withOpacity(0.6),
              size: 54,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            "Electronics",
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 16,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }
}
