import 'package:crafty_bay/presentation/state_holders/cart_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/main_bottom_nav_bar_controller.dart';
import 'package:crafty_bay/presentation/utility/app_colors.dart';
import 'package:crafty_bay/presentation/widgets/cart_product_item.dart';
import 'package:crafty_bay/presentation/widgets/centered_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartListScreen extends StatefulWidget {
  const CartListScreen({super.key});

  @override
  State<CartListScreen> createState() => _CartListScreenState();
}

class _CartListScreenState extends State<CartListScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<CartListController>().getCartList();
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
            GetBuilder<CartListController>(
              builder: (cartListController) {
                if (cartListController.inProgress) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height - 204.1,
                    child: const CenteredCircularProgressIndicator(),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: cartListController.cartItemList.length,
                    itemBuilder: (context, index) {
                      return CartProductItem(
                        itemQuantity: (int.parse(cartListController.cartItemList[index].size?.split("-")[1] ?? "0")),
                        cartItem: cartListController.cartItemList[index],
                        cartProduct: cartListController.cartProductList[index],
                      );
                    },
                  ),
                );
              },
            ),
            GetBuilder<CartListController>(builder: (cartListController) {
              if (cartListController.inProgress) {
                return const CenteredCircularProgressIndicator();
              }
              return _buildCheckoutWidget(cartListController);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckoutWidget(CartListController cartListController) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 8,
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
          _buildTotalPriceWidget(cartListController),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(fixedSize: const Size(100, 20), padding: EdgeInsets.zero),
            child: const Text("Checkout"),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalPriceWidget(CartListController cartListController) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Total Price",
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          "\$${cartListController.cartListTotalPrice}",
          style: const TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
      ],
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
            title: const Text("Cart"),
          ),
        ],
      ),
    );
  }
}
