import 'package:crafty_bay/presentation/state_holders/product_list_by_category_controller.dart';
import 'package:crafty_bay/presentation/utility/app_colors.dart';
import 'package:crafty_bay/presentation/utility/assets_path.dart';
import 'package:crafty_bay/presentation/widgets/centered_circular_progress_indicator.dart';
import 'package:crafty_bay/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({
    super.key,
    required this.categoryName,
    required this.categoryId,
  });

  final String categoryName;
  final int categoryId;

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<ProductListByCategoryController>().getProductListByCategory(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _appBar(),
          _buildProductList(),
        ],
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
                Get.back();
              },
            ),
            title: Text(widget.categoryName),
          ),
        ],
      ),
    );
  }

  Widget _buildProductList() {
    return Expanded(
      child: GetBuilder<ProductListByCategoryController>(builder: (productListByCategoryController) {
        if (productListByCategoryController.inProgress) {
          return const CenteredCircularProgressIndicator();
        }
        if (productListByCategoryController.productList.isEmpty) {
          return _buildOutOfStock();
        }
        return GridView.builder(
          padding: EdgeInsets.zero,
          itemCount: productListByCategoryController.productList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.85,
          ),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: FittedBox(
                child: ProductCard(
                  product: productListByCategoryController.productList[index],
                ),
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildOutOfStock() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 120,
            width: 120,
            child: Image.asset(AssetsPath.soldOutIcon),
          ),
          const SizedBox(height: 12),
          const Text(
            "OUT OF STOCK !!",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 28,
              color: AppColors.primaryColor,
            ),
          ),
          const Text(
            "More Products Will be Added Later",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
