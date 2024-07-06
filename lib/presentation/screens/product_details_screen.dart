import 'package:crafty_bay/data/models/cart_model.dart';
import 'package:crafty_bay/data/models/product_details_model.dart';
import 'package:crafty_bay/presentation/screens/reviews_screen.dart';
import 'package:crafty_bay/presentation/state_holders/add_to_cart_controller.dart';
import 'package:crafty_bay/presentation/state_holders/add_to_wish_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/product_details_controller.dart';
import 'package:crafty_bay/presentation/utility/app_colors.dart';
import 'package:crafty_bay/presentation/widgets/centered_circular_progress_indicator.dart';
import 'package:crafty_bay/presentation/widgets/color_picker.dart';
import 'package:crafty_bay/presentation/widgets/product_image_carousel_slider.dart';
import 'package:crafty_bay/presentation/widgets/size_picker.dart';
import 'package:crafty_bay/presentation/widgets/wish_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({
    super.key,
    required this.productId,
  });

  final int productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  RxInt _itemCounter = 1.obs;
  late String _selectedColor;
  late String _selectedSize;

  @override
  void initState() {
    super.initState();
    Get.find<ProductDetailsController>().getProductDetailsById(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          _appBar(),
          GetBuilder<ProductDetailsController>(
            builder: (productDetailsController) {
              if (productDetailsController.inProgress) {
                return SizedBox(
                  height: screenHeight - 145.1,
                  child: const CenteredCircularProgressIndicator(),
                );
              }
              if (productDetailsController.errorMessage.isNotEmpty) {
                return Center(
                  child: Text(productDetailsController.errorMessage),
                );
              }
              ProductDetailsModel productDetails = productDetailsController.productDetailsModel;
              List<String> sizes = productDetails.size?.split(",") ?? [];
              _selectedSize = sizes.first;
              return Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ProductImageCarouselSlider(
                        productImages: [
                          productDetails.img1 ?? "",
                          productDetails.img2 ?? "",
                          productDetails.img3 ?? "",
                          productDetails.img4 ?? "",
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                _buildProductName(productDetails.product?.title ?? ""),
                                _buildItemCounter(),
                              ],
                            ),
                            _buildReviewSection(productDetailsController.productDetailsModel),
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
                              colorCodes: _getRefinedColorCodeList(productDetails.color?.split(",") ?? []),
                              onChange: (String selectedColor) {
                                _selectedColor = selectedColor;
                              },
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
                              sizes: sizes,
                              onChange: (String selectedSize) {
                                _selectedSize = selectedSize;
                              },
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
                            const SizedBox(height: 8),
                            Text(
                              productDetails.product?.shortDes ?? "",
                            ),
                            const SizedBox(height: 8),
                            Text(
                              productDetails.des ?? "",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          GetBuilder<ProductDetailsController>(
            builder: (productDetailsController) {
              if (productDetailsController.inProgress) {
                return const CenteredCircularProgressIndicator();
              }
              if (productDetailsController.errorMessage.isNotEmpty) {
                return Center(
                  child: Text(productDetailsController.errorMessage),
                );
              }
              return _buildAddToCartSection(productDetailsController.productDetailsModel);
            },
          ),
        ],
      ),
    );
  }

  List<String> _getRefinedColorCodeList(List<String> unrefinedColorCodeList) {
    List<String> refinedColorCodeList = [];
    for (var unrefinedColorCode in unrefinedColorCodeList) {
      refinedColorCodeList.add(_colorCodeRefiner(unrefinedColorCode));
    }
    _selectedColor = refinedColorCodeList[0];
    return refinedColorCodeList;
  }

  String _colorCodeRefiner(String unrefinedColorCode) {
    final StringBuffer refinedColorCode = StringBuffer();
    if (unrefinedColorCode.length == 6 || unrefinedColorCode.length == 7) {
      refinedColorCode.write('ff');
    }
    refinedColorCode.write(unrefinedColorCode.replaceFirst("#", ""));
    return refinedColorCode.toString();
  }

  Widget _buildAddToCartSection(ProductDetailsModel productDetails) {
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
          _buildPriceWidget(productDetails.product?.price ?? "0"),
          GetBuilder<AddToCartController>(
            builder: (addToCartController) {
              if (addToCartController.inProgress) {
                return const CenteredCircularProgressIndicator();
              }
              return ElevatedButton(
                onPressed: () {
                  CartModel cartModel = CartModel(
                    productId: widget.productId,
                    color: _selectedColor,
                    size: "$_selectedSize-${_itemCounter.value}",
                  );
                  addToCartController.addToCart(cartModel).then(
                    (result) {
                      if (result) {
                        Get.snackbar(
                          "",
                          "",
                          titleText: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              "Add To Cart Successfully",
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          animationDuration: const Duration(milliseconds: 500),
                          backgroundColor: Colors.black54,
                          borderRadius: 4,
                          margin: const EdgeInsets.only(top: 12, left: 4, right: 50, bottom: 0),
                          padding: const EdgeInsets.only(top: 16, bottom: 0),
                          duration: const Duration(seconds: 3),
                          snackPosition: SnackPosition.TOP,
                          leftBarIndicatorColor: Colors.green,
                          barBlur: 2,
                        );
                      }
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(120, 20),
                  padding: EdgeInsets.zero,
                ),
                child: const Text("Add To Cart"),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProductName(String productName) {
    return Expanded(
      child: Text(
        productName,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black.withOpacity(0.7),
        ),
      ),
    );
  }

  Widget _buildPriceWidget(String price) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Price",
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          "\$$price",
          style: const TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  Widget _buildReviewSection(ProductDetailsModel productDetails) {
    return Wrap(
      spacing: 10,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const Icon(
              Icons.star,
              color: Colors.amber,
              size: 20,
            ),
            Text(
              "${productDetails.product?.star ?? 0}",
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black45,
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            Get.to(() => ReviewsScreen(productId: productDetails.productId!));
          },
          child: const Text(
            "Reviews",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        GetBuilder<AddToWishListController>(builder: (addToWishListController) {
          if (addToWishListController.inProgress) {
            return Transform.scale(
              scale: 0.4,
              child: const CircularProgressIndicator(),
            );
          }
          return WishButton(
            // isSelected: true,
            onTap: () {
              addToWishListController.addToWishList(widget.productId);
            },
          );
        }),
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
              color: _itemCounter.value <= 1 ? AppColors.primaryColor.withOpacity(0.5) : AppColors.primaryColor,
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
              color: _itemCounter.value >= 20 ? AppColors.primaryColor.withOpacity(0.5) : AppColors.primaryColor,
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
