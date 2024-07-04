import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/models/review.dart';
import 'package:crafty_bay/data/models/review_model.dart';
import 'package:crafty_bay/data/network_caller/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class ReviewController extends GetxController {
  bool _inProgress = false;
  String _errorMessage = "";
  bool get inProgress => _inProgress;
  String get errorMessage => _errorMessage;
  List<Review> _reviewList = [];
  List<Review> get reviewList => _reviewList;
  Future<bool> getReviewList(int productId) async {
    late bool isSuccess;
    _inProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(url: Urls.reviewByProductId(productId));
    if(response.isSuccess) {
      isSuccess = true;
      _reviewList = ReviewModel.fromJson(response.responseData).reviewList;
    } else {
      isSuccess = false;
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}