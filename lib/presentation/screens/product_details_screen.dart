import 'package:crafty_bay/presentation/screens/reviews_screen.dart';
import 'package:crafty_bay/presentation/utility/app_colors.dart';
import 'package:crafty_bay/presentation/widgets/color_picker.dart';
import 'package:crafty_bay/presentation/widgets/product_image_carousel_slider.dart';
import 'package:crafty_bay/presentation/widgets/size_picker.dart';
import 'package:crafty_bay/presentation/widgets/wish_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  RxInt _itemCounter = 1.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _appBar(),
          const ProductImageCarouselSlider(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _buildProductName(),
                        _buildItemCounter(),
                      ],
                    ),
                    _buildReviewSection(),
                    Text(
                      "Color",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ColorPicker(
                      colors: const [
                        Colors.green,
                        Colors.red,
                        Colors.blue,
                        Colors.amber,
                        Colors.purple,
                      ],
                      onChange: (Color selectedColor) {},
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Size",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizePicker(
                      sizes: const [
                        "XL",
                        "XXL",
                        "2L",
                        "M",
                        "S",
                        "L",
                      ],
                      onChange: (String selectedSize) {},
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                    const Text(
                      '''Tesla primarily uses lithium-ion batteries, known for their high energy density and efficiency.Tesla primarily uses lithium-ion batteries, known for their high energy density and efficiency.Tesla primarily uses lithium-ion batteries, known for their high energy density and efficiency.Tesla primarily uses lithium-ion batteries, known for their high energy density and efficiency.Tesla primarily uses lithium-ion batteries, known for their high energy density and efficiency.''',
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
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
                _buildPriceWidget(),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(120, 20),
                    padding: EdgeInsets.zero,
                  ),
                  child: const Text("Add To Cart"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildProductName() {
    return Expanded(
      child: Text(
        "Tesla Battery Special Edition Heavy Duty 2024KG4",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black.withOpacity(0.7),
        ),
      ),
    );
  }

  Widget _buildPriceWidget() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Price",
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          "\$17000",
          style: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  Widget _buildReviewSection() {
    return Wrap(
      spacing: 10,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        const Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Icon(
              Icons.star,
              color: Colors.amber,
              size: 20,
            ),
            Text(
              "3.4",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black45,
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            Get.to(() => const ReviewsScreen());
          },
          child: const Text(
            "Reviews",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        const WishButton(),
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
                Get.back();
              },
            ),
            title: const Text("Product Details"),
          ),
        ],
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
