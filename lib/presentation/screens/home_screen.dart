import 'package:crafty_bay/presentation/state_holders/home_screen_carousel_slider_controller.dart';
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
                        onTapSeeAll: () {},
                      ),
                      const SizedBox(height: 8),
                      _buildAllCategoryList(),
                      const SizedBox(height: 8),
                      SectionHeader(
                        header: "Popular",
                        onTapSeeAll: () {},
                      ),
                      const SizedBox(height: 8),
                      _buildPopularProductList(),
                      const SizedBox(height: 8),
                      SectionHeader(
                        header: "Special",
                        onTapSeeAll: () {},
                      ),
                      const SizedBox(height: 8),
                      _buildSpecialProductList(),
                      const SizedBox(height: 8),
                      SectionHeader(
                        header: "New",
                        onTapSeeAll: () {},
                      ),
                      const SizedBox(height: 8),
                      _buildNewProductList(),
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
              child: const Row(
                children: [
                  Text(
                    "No",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Icon(
                    Icons.cancel_outlined,
                    color: Colors.green,
                  ),
                ],
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

  Widget _buildPopularProductList() {
    return SizedBox(
      height: 210,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return const ProductCard();
        },
        separatorBuilder: (context, index) {
          return const SizedBox(width: 8);
        },
      ),
    );
  }

  Widget _buildNewProductList() {
    return SizedBox(
      height: 210,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return const ProductCard();
        },
        separatorBuilder: (context, index) {
          return const SizedBox(width: 8);
        },
      ),
    );
  }

  Widget _buildSpecialProductList() {
    return SizedBox(
      height: 210,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return const ProductCard();
        },
        separatorBuilder: (context, index) {
          return const SizedBox(width: 8);
        },
      ),
    );
  }

  Widget _buildAllCategoryList() {
    return SizedBox(
      height: 115,
      child: ListView.separated(
        itemCount: 8,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return const CategoryItem();
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
