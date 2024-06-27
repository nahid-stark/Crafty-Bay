import 'package:crafty_bay/presentation/state_holders/main_bottom_nav_bar_controller.dart';
import 'package:crafty_bay/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
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
            _buildWishList(),
          ],
        ),
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
                Get.find<MainBottomNavBarController>().backToHome();
              },
            ),
            title: const Text("Wish List"),
          ),
        ],
      ),
    );
  }

  Widget _buildWishList() {
    return Expanded(
      child: GridView.builder(
        padding: EdgeInsets.zero,
        itemCount: 15,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.85,
        ),
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: FittedBox(
              // child: ProductCard(
              //   showAddToWishList: false,
              // ),
            ),
          );
        },
      ),
    );
  }
}
