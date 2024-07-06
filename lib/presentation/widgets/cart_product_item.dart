import 'package:crafty_bay/data/models/cart_item.dart';
import 'package:crafty_bay/data/models/product.dart';
import 'package:crafty_bay/presentation/state_holders/cart_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/delete_cart_item_controller.dart';
import 'package:crafty_bay/presentation/utility/app_colors.dart';
import 'package:crafty_bay/presentation/utility/assets_path.dart';
import 'package:crafty_bay/presentation/widgets/network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartProductItem extends StatefulWidget {
  const CartProductItem({
    super.key,
    required this.cartItem,
    required this.cartProduct,
    required this.itemQuantity,
  });

  final CartItem cartItem;
  final Product cartProduct;
  final int itemQuantity;

  @override
  State<CartProductItem> createState() => _CartProductItemState();
}

class _CartProductItemState extends State<CartProductItem> {
  int deletedProductId = -999;

  @override
  Widget build(BuildContext context) {
    RxInt itemCounter = widget.itemQuantity.obs;
    return Card(
      surfaceTintColor: Colors.white,
      elevation: 4,
      margin: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      child: Row(
        children: [
          _buildProductImage(widget.cartProduct.image ?? ""),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildProductDetails(itemCounter),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductDetails(RxInt itemCounter) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProductName(),
                  _buildProductColorAndSize(),
                ],
              ),
            ),
            GetBuilder<DeleteCartItemController>(
              builder: (deleteCartItemController) {
                if (deleteCartItemController.inProgress && deletedProductId == widget.cartItem.productId) {
                  return Transform.scale(
                    scale: 0.5,
                    child: const CircularProgressIndicator(),
                  );
                }
                return IconButton(
                  onPressed: () async {
                    deletedProductId = widget.cartItem.productId!;
                    final bool result = await deleteCartItemController.deleteCartItem(
                      widget.cartItem.productId!,
                    );
                    if (result) {
                      Get.find<CartListController>().getCartList();
                    }
                  },
                  icon: Image.asset(
                    AssetsPath.deleteIcon,
                    height: 25,
                    width: 25,
                  ),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 18),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "\$${widget.cartProduct.price}",
              style: const TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            _buildItemCounter(itemCounter),
          ],
        ),
      ],
    );
  }

  Widget _buildProductColorAndSize() {
    return Wrap(
      spacing: 16,
      children: [
        Wrap(
          children: [
            const Text(
              "Color: ",
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
            CircleAvatar(
              backgroundColor: Color(int.parse(widget.cartItem.color ?? "", radix: 16)),
              radius: 12,
            ),
          ],
        ),
        Text(
          "Size: ${widget.cartItem.size?.split("-")[0]}",
          style: const TextStyle(
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildProductName() {
    return Text(
      widget.cartProduct.title ?? "",
      maxLines: 1,
      style: const TextStyle(
        fontSize: 16,
        overflow: TextOverflow.ellipsis,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildProductImage(String imgUrl) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: NetworkImageWidget(
        url: imgUrl,
        height: 80,
        width: 80,
        boxFit: BoxFit.fill,
      ),
    );
  }

  Widget _buildItemCounter(RxInt itemCounter) {
    return Obx(
      () => Row(
        children: [
          Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
              color: itemCounter.value <= 1 ? AppColors.primaryColor.withOpacity(0.5) : AppColors.primaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              onPressed: itemCounter.value <= 1
                  ? null
                  : () {
                      itemCounter--;
                    },
              icon: const Icon(Icons.remove, color: Colors.white),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ),
          const SizedBox(width: 3),
          Text(
            itemCounter < 10 ? "0$itemCounter" : "$itemCounter",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 3),
          Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
              color: itemCounter.value >= 20 ? AppColors.primaryColor.withOpacity(0.5) : AppColors.primaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              onPressed: itemCounter.value >= 20
                  ? null
                  : () {
                      itemCounter++;
                    },
              icon: const Icon(Icons.add, color: Colors.white),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ),
        ],
      ),
    );
  }
}
