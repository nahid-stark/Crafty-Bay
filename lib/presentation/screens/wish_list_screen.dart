import 'package:crafty_bay/presentation/state_holders/main_bottom_nav_bar_controller.dart';
import 'package:crafty_bay/presentation/state_holders/wish_list_controller.dart';
import 'package:crafty_bay/presentation/widgets/centered_circular_progress_indicator.dart';
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
  void initState() {
    super.initState();
    Get.find<WishListController>().getWishList();
  }

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
            GetBuilder<WishListController>(builder: (wishListController) {
              if (wishListController.inProgress) {
                return const SizedBox(
                  height: 500,
                  child: CenteredCircularProgressIndicator(),
                );
              }
              return _buildWishList(wishListController);
            }),
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

  Widget _buildWishList(WishListController wishListController) {
    return Expanded(
      child: GridView.builder(
        padding: EdgeInsets.zero,
        itemCount: wishListController.wishProductList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.85,
        ),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: FittedBox(
              child: ProductCard(
                product: wishListController.wishProductList[index],
                showAddToWishList: false,
              ),
            ),
          );
        },
      ),
    );
  }
}
