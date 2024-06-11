import 'package:crafty_bay/presentation/state_holders/main_bottom_nav_bar_controller.dart';
import 'package:crafty_bay/presentation/widgets/category_item.dart';
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
        body: Column(
          children: [
            _appBar(),
            _buildCategoryList(),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryList() {
    return Expanded(
      child: GridView.builder(
        padding: EdgeInsets.zero,
        itemCount: 15,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 0.70,
        ),
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.all(8),
            child: FittedBox(
              child: CategoryItem(),
            ),
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
