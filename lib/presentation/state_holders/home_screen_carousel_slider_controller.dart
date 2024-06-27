import 'package:crafty_bay/data/models/home_screen_carousel_slider_data.dart';
import 'package:crafty_bay/data/models/home_screen_carousel_slider_model.dart';
import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/network_caller/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class HomeScreenCarouselSliderController extends GetxController {
  bool _inProgress = false;
  String _errorMessage = "";
  List<HomeScreenCarouselSliderData> _homeScreenCarouselSliderDataList = <HomeScreenCarouselSliderData>[];

  bool get inProgress => _inProgress;

  List<HomeScreenCarouselSliderData> get homeScreenCarouselSliderDataList =>
      _homeScreenCarouselSliderDataList;

  String get errorMessage => _errorMessage;

  Future<bool> getHomeScreenCarouselSliderData() async {
    late bool isSuccess;
    _inProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(url: Urls.homeScreenCarouselSlider);
    if (response.isSuccess) {
      isSuccess = true;
      _homeScreenCarouselSliderDataList =
          HomeScreenCarouselSliderModel.fromJson(response.responseData).homeScreenCarouselSliderDataList;
    } else {
      isSuccess = false;
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
