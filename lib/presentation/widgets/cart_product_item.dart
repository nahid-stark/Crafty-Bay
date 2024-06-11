import 'package:crafty_bay/presentation/utility/app_colors.dart';
import 'package:crafty_bay/presentation/utility/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartProductItem extends StatefulWidget {
  const CartProductItem({super.key});

  @override
  State<CartProductItem> createState() => _CartProductItemState();
}

class _CartProductItemState extends State<CartProductItem> {
  RxInt _itemCounter = 1.obs;

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.white,
      elevation: 4,
      margin: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      child: Row(
        children: [
          _buildProductImage(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildProductDetails(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductDetails() {
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
            IconButton(
              onPressed: () {},
              icon: Image.asset(
                AssetsPath.deleteIcon,
                height: 25,
                width: 25,
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "\$1000",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            _buildItemCounter(),
          ],
        ),
      ],
    );
  }

  Widget _buildProductColorAndSize() {
    return const Wrap(
      spacing: 16,
      children: [
        Text(
          "Color: Red",
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
        Text(
          "Size: XL",
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildProductName() {
    return const Text(
      "Tesla Model 3 Battery",
      maxLines: 1,
      style: TextStyle(
        fontSize: 16,
        overflow: TextOverflow.ellipsis,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildProductImage() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Image.asset(
        "assets/icons/temp_image.png",
        width: 100,
      ),
    );
  }

  Widget _buildItemCounter() {
    return Obx(
      () => Row(
        children: [
          Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
              color:
                  _itemCounter.value <= 1 ? AppColors.primaryColor.withOpacity(0.5) : AppColors.primaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              onPressed: _itemCounter.value <= 1
                  ? null
                  : () {
                      _itemCounter--;
                    },
              icon: const Icon(Icons.remove, color: Colors.white),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ),
          const SizedBox(width: 3),
          Text(
            _itemCounter < 10 ? "0$_itemCounter" : "$_itemCounter",
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
              color:
                  _itemCounter.value >= 20 ? AppColors.primaryColor.withOpacity(0.5) : AppColors.primaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              onPressed: _itemCounter.value >= 20
                  ? null
                  : () {
                      _itemCounter++;
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
