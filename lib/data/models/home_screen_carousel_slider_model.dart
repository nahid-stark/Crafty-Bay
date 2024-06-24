import 'package:crafty_bay/data/models/home_screen_carousel_slider_data.dart';

class HomeScreenCarouselSliderModel {
  String msg = "";
  List<HomeScreenCarouselSliderData> homeScreenCarouselSliderDataList = <HomeScreenCarouselSliderData>[];

  HomeScreenCarouselSliderModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      json['data'].forEach(
        (value) {
          homeScreenCarouselSliderDataList.add(HomeScreenCarouselSliderData.fromJson(value));
        },
      );
    }
  }
}
