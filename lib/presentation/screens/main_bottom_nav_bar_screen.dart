import 'package:crafty_bay/presentation/screens/cart_list_screen.dart';
import 'package:crafty_bay/presentation/screens/category_list_screen.dart';
import 'package:crafty_bay/presentation/screens/home_screen.dart';
import 'package:crafty_bay/presentation/screens/wish_list_screen.dart';
import 'package:crafty_bay/presentation/state_holders/category_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/home_screen_carousel_slider_controller.dart';
import 'package:crafty_bay/presentation/state_holders/main_bottom_nav_bar_controller.dart';
import 'package:crafty_bay/presentation/state_holders/new_product_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/popular_product_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/special_product_list_controller.dart';
import 'package:crafty_bay/presentation/utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainBottomNavBarScreen extends StatefulWidget {
  const MainBottomNavBarScreen({super.key});

  @override
  State<MainBottomNavBarScreen> createState() => _MainBottomNavBarScreenState();
}

class _MainBottomNavBarScreenState extends State<MainBottomNavBarScreen> {
  final MainBottomNavBarController _navBarController = Get.find<MainBottomNavBarController>();
  final List<Widget> _screens = const [
    HomeScreen(),
    CategoryListScreen(),
    CartListScreen(),
    WishListScreen(),
  ];

  @override
  void initState() {
    super.initState();
    Get.find<HomeScreenCarouselSliderController>().getHomeScreenCarouselSliderData();
    Get.find<CategoryListController>().getCategoryListData();
    Get.find<PopularProductListController>().getPopularProductList();
    Get.find<SpecialProductListController>().getSpecialProductList();
    Get.find<NewProductListController>().getNewProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<MainBottomNavBarController>(
        builder: (controller) {
          return _screens[_navBarController.selectedIndex];
        },
      ),
      bottomNavigationBar: GetBuilder<MainBottomNavBarController>(
        builder: (context) {
          return BottomNavigationBar(
            currentIndex: _navBarController.selectedIndex,
            onTap: _navBarController.changeIndex,
            selectedItemColor: AppColors.primaryColor,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            iconSize: 25,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.dashboard_outlined), label: "Category"),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_basket_outlined), label: "Cart"),
              BottomNavigationBarItem(icon: Icon(Icons.favorite_border_outlined), label: "Wish"),
            ],
          );
        },
      ),
    );
  }
}
