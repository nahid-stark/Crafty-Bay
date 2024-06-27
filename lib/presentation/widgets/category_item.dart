import 'package:crafty_bay/data/models/category_list_data.dart';
import 'package:crafty_bay/presentation/screens/product_list_screen.dart';
import 'package:crafty_bay/presentation/utility/app_colors.dart';
import 'package:crafty_bay/presentation/widgets/network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.categoryListData,
  });

  final CategoryListData categoryListData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => ProductListScreen(
            categoryName: categoryListData.categoryName ?? "",
            categoryId: categoryListData.id!,
          ),
        );
      },
      child: Column(
        children: [
          /*Container*/ SizedBox(
            //padding: const EdgeInsets.all(4),
            // decoration: BoxDecoration(
            //   color: AppColors.primaryColor.withOpacity(0.1),
            //   borderRadius: BorderRadius.circular(16),
            // ),
            child: NetworkImageWidget(
              url: categoryListData.categoryImg ?? "",
              height: 60,
              width: 60,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            categoryListData.categoryName ?? "",
            maxLines: 1,
            style: const TextStyle(
              color: AppColors.primaryColor,
              fontSize: 16,
              overflow: TextOverflow.ellipsis,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }
}
