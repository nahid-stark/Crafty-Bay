import 'package:crafty_bay/data/models/category_list_data.dart';
import 'package:crafty_bay/data/models/product.dart';
import 'package:crafty_bay/presentation/state_holders/category_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/home_screen_carousel_slider_controller.dart';
import 'package:crafty_bay/presentation/state_holders/main_bottom_nav_bar_controller.dart';
import 'package:crafty_bay/presentation/state_holders/new_product_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/popular_product_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/special_product_list_controller.dart';
import 'package:crafty_bay/presentation/utility/app_colors.dart';
import 'package:crafty_bay/presentation/utility/assets_path.dart';
import 'package:crafty_bay/presentation/widgets/app_bar_actions.dart';
import 'package:crafty_bay/presentation/widgets/app_bar_logo.dart';
import 'package:crafty_bay/presentation/widgets/category_item.dart';
import 'package:crafty_bay/presentation/widgets/centered_circular_progress_indicator.dart';
import 'package:crafty_bay/presentation/widgets/home_screen_carousel_slider.dart';
import 'package:crafty_bay/presentation/widgets/product_card.dart';
import 'package:crafty_bay/presentation/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchBarTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) {
        Get.dialog(
          barrierDismissible: false,
          _buildExitAppAlertDialog(),
        );
      },
      child: Scaffold(
        body: Column(
          children: [
            _appBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [
                      _buildSearchBar(),
                      const SizedBox(height: 16),
                      GetBuilder<HomeScreenCarouselSliderController>(
                        builder: (carouselSliderController) {
                          if (carouselSliderController.inProgress) {
                            return const SizedBox(
                              height: 205,
                              child: CenteredCircularProgressIndicator(),
                            );
                          }
                          return HomeScreenCarouselSlider(
                            carouselSliderDataList: carouselSliderController.homeScreenCarouselSliderDataList,
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                      SectionHeader(
                        header: "All Categories",
                        onTapSeeAll: () {
                          Get.find<MainBottomNavBarController>().goToAllCategoriesScreen();
                        },
                      ),
                      const SizedBox(height: 8),
                      GetBuilder<CategoryListController>(
                        builder: (categoryListController) {
                          if (categoryListController.inProgress) {
                            return const SizedBox(
                              height: 115,
                              child: CenteredCircularProgressIndicator(),
                            );
                          }
                          return _buildAllCategoryList(categoryListController.categoryListItems);
                        },
                      ),
                      const SizedBox(height: 8),
                      SectionHeader(
                        header: "Popular",
                        onTapSeeAll: () {},
                      ),
                      const SizedBox(height: 8),
                      GetBuilder<PopularProductListController>(
                        builder: (popularProductListController) {
                          if (popularProductListController.popularProductInProgress) {
                            return const SizedBox(
                              height: 200,
                              child: CenteredCircularProgressIndicator(),
                            );
                          }
                          return _buildPopularProductList(popularProductListController.productList);
                        },
                      ),
                      const SizedBox(height: 8),
                      SectionHeader(
                        header: "Special",
                        onTapSeeAll: () {},
                      ),
                      const SizedBox(height: 8),
                      GetBuilder<SpecialProductListController>(
                        builder: (specialProductListController) {
                          if (specialProductListController.inProgress) {
                            return const SizedBox(
                              height: 200,
                              child: CenteredCircularProgressIndicator(),
                            );
                          }
                          return _buildSpecialProductList(specialProductListController.productList);
                        },
                      ),
                      const SizedBox(height: 8),
                      SectionHeader(
                        header: "New",
                        onTapSeeAll: () {},
                      ),
                      const SizedBox(height: 8),
                      GetBuilder<NewProductListController>(
                        builder: (newProductListController) {
                          if (newProductListController.inProgress) {
                            return const SizedBox(
                              height: 200,
                              child: CenteredCircularProgressIndicator(),
                            );
                          }
                          return _buildNewProductList(newProductListController.productList);
                        }
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExitAppAlertDialog() {
    return AlertDialog(
      title: const Row(
        children: [
          AppBarLogo(),
        ],
      ),
      content: const Text(
        "Are You Want to Exit?",
        style: TextStyle(
          fontSize: 22,
          color: AppColors.primaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text(
                "No",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              child: const Row(
                children: [
                  Text(
                    "Yes",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Icon(
                    Icons.exit_to_app_sharp,
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPopularProductList(List<Product> productList) {
    return SizedBox(
      height: 190,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: productList.length,
        itemBuilder: (context, index) {
          return ProductCard(product: productList[index]);
        },
        separatorBuilder: (context, index) {
          return const SizedBox(width: 8);
        },
      ),
    );
  }

  Widget _buildNewProductList(List<Product> productList) {
    return SizedBox(
      height: 190,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: productList.length,
        itemBuilder: (context, index) {
          return ProductCard(product: productList[index]);
        },
        separatorBuilder: (context, index) {
          return const SizedBox(width: 8);
        },
      ),
    );
  }

  Widget _buildSpecialProductList(List<Product> productList) {
    return SizedBox(
      height: 190,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: productList.length,
        itemBuilder: (context, index) {
          return ProductCard(product: productList[index]);
        },
        separatorBuilder: (context, index) {
          return const SizedBox(width: 8);
        },
      ),
    );
  }

  Widget _buildAllCategoryList(List<CategoryListData> categoryListItems) {
    return SizedBox(
      height: 90,
      child: ListView.separated(
        itemCount: categoryListItems.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return CategoryItem(categoryListData: categoryListItems[index]);
        },
        separatorBuilder: (context, index) {
          return const SizedBox(width: 18);
        },
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: _searchBarTEController,
      decoration: InputDecoration(
        hintText: "Search",
        prefixIcon: const Icon(Icons.search_outlined),
        fillColor: Colors.grey.shade300,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12),
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
            title: const AppBarLogo(),
            actions: [
              AppBarActions(
                onTap: () {},
                iconPath: AssetsPath.userProfileIcon,
              ),
              const SizedBox(width: 6),
              AppBarActions(
                onTap: () {},
                iconPath: AssetsPath.phoneIcon,
              ),
              const SizedBox(width: 6),
              AppBarActions(
                onTap: () {},
                iconPath: AssetsPath.notificationIcon,
              ),
              const SizedBox(width: 4),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchBarTEController.dispose();
    super.dispose();
  }
}
