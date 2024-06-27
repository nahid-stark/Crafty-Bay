import 'package:crafty_bay/presentation/state_holders/category_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/home_screen_carousel_slider_controller.dart';
import 'package:crafty_bay/presentation/state_holders/main_bottom_nav_bar_controller.dart';
import 'package:crafty_bay/presentation/state_holders/new_product_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/popular_product_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/product_list_by_category_controller.dart';
import 'package:crafty_bay/presentation/state_holders/special_product_list_controller.dart';
import 'package:get/get.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainBottomNavBarController());
    Get.lazyPut(() => HomeScreenCarouselSliderController());
    Get.lazyPut(() => CategoryListController());
    Get.put(ProductListByCategoryController());
    Get.lazyPut(() => PopularProductListController());
    Get.lazyPut(() => SpecialProductListController());
    Get.lazyPut(() => NewProductListController());
  }
}
