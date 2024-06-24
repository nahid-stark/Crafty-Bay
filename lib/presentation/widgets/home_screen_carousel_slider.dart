import 'package:carousel_slider/carousel_slider.dart';
import 'package:crafty_bay/data/models/home_screen_carousel_slider_data.dart';
import 'package:crafty_bay/presentation/utility/app_colors.dart';
import 'package:flutter/material.dart';

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
                child: Text(
                  carouselSliderItem.title ?? "",
                  style: const TextStyle(fontSize: 16.0),
                ),
              );
            },
          );
        },
      ).toList(),
    );
  }
}
