import 'package:carousel_slider/carousel_slider.dart';
import 'package:crafty_bay/data/models/home_screen_carousel_slider_data.dart';
import 'package:crafty_bay/presentation/screens/product_details_screen.dart';
import 'package:crafty_bay/presentation/utility/app_colors.dart';
import 'package:crafty_bay/presentation/widgets/network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreenCarouselSlider extends StatefulWidget {
  const HomeScreenCarouselSlider({
    super.key,
    required this.carouselSliderDataList,
  });

  final List<HomeScreenCarouselSliderData> carouselSliderDataList;

  @override
  State<HomeScreenCarouselSlider> createState() => _HomeScreenCarouselSliderState();
}

class _HomeScreenCarouselSliderState extends State<HomeScreenCarouselSlider> {
  final ValueNotifier<int> _selectedPageIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildCarouselSlider(),
        const SizedBox(height: 8),
        _buildDotIndicator(),
      ],
    );
  }

  Widget _buildDotIndicator() {
    return ValueListenableBuilder(
      valueListenable: _selectedPageIndex,
      builder: (context, currentPage, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < widget.carouselSliderDataList.length; i++)
              Container(
                height: 15,
                width: 15,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: i == currentPage ? AppColors.primaryColor : Colors.white,
                  border:
                      Border.all(color: i == currentPage ? AppColors.primaryColor : Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildCarouselSlider() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 180,
        viewportFraction: 1,
        onPageChanged: (index, _) {
          _selectedPageIndex.value = index;
        },
      ),
      items: widget.carouselSliderDataList.map(
        (carouselSliderItem) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Row(
                  children: [
                    _buildSliderImage(carouselSliderItem),
                    _buildSliderTitleAndButton(carouselSliderItem, carouselSliderItem.productId!),
                  ],
                ),
              );
            },
          );
        },
      ).toList(),
    );
  }

  Widget _buildSliderTitleAndButton(HomeScreenCarouselSliderData carouselSliderItem, int productId) {
    return Expanded(
      flex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            carouselSliderItem.title ?? "",
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: 100,
            height: 30,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                backgroundColor: Colors.white,
                foregroundColor: AppColors.primaryColor,
              ),
              onPressed: () {
                Get.to(() => ProductDetailsScreen(productId: productId));
              },
              child: const Text(
                "Buy Now",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliderImage(HomeScreenCarouselSliderData carouselSliderItem) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 12),
        child: SizedBox(
          height: double.maxFinite,
          width: 20,
          child: NetworkImageWidget(
            url: carouselSliderItem.image ?? "",
            height: double.maxFinite,
            width: double.maxFinite,
            boxFit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
