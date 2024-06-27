import 'package:crafty_bay/data/models/category_list_data.dart';
import 'package:crafty_bay/presentation/state_holders/category_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/main_bottom_nav_bar_controller.dart';
import 'package:crafty_bay/presentation/widgets/category_item.dart';
import 'package:crafty_bay/presentation/widgets/centered_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({super.key});

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) {
        Get.find<MainBottomNavBarController>().backToHome();
      },
      child: Scaffold(
        body: GetBuilder<CategoryListController>(
          builder: (categoryListController) {
            if(categoryListController.inProgress) {
              return const CenteredCircularProgressIndicator();
            }
            return RefreshIndicator(
              onRefresh: categoryListController.getCategoryListData,
              child: Column(
                children: [
                  _appBar(),
                  _buildCategoryList(categoryListController.categoryListItems),
                ],
              ),
            );
          }
        ),
      ),
    );
  }

  Widget _buildCategoryList(List<CategoryListData> categoryListItems) {
    return Expanded(
      child: GridView.builder(
        padding: EdgeInsets.zero,
        itemCount: categoryListItems.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 0.70,
        ),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: CategoryItem(categoryListData: categoryListItems[index]),
          );
        },
      ),
    );
  }

  Widget _appBar() {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 0.1),
          AppBar(
            title: const Text("Categories"),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Get.find<MainBottomNavBarController>().backToHome();
              },
            ),
          ),
        ],
      ),
    );
  }
}
