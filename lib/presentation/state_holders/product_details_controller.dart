import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/models/product_details_model.dart';
import 'package:crafty_bay/data/models/product_details_wrapper_model.dart';
import 'package:crafty_bay/data/network_caller/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  bool _inProgress = false;
  String _errorMessage = "";
  ProductDetailsModel _productDetailsModel = ProductDetailsModel();

  bool get inProgress => _inProgress;

  ProductDetailsModel get productDetailsModel => _productDetailsModel;

  String get errorMessage => _errorMessage;

  Future<bool> getProductDetailsById(int productId) async {
    late bool isSuccess;
    _inProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(url: Urls.productDetailsById(productId));
    if (response.isSuccess) {
      if(_errorMessage.isNotEmpty) {
        _errorMessage = "";
      }
      isSuccess = true;
      _productDetailsModel = ProductDetailsWrapperModel.fromJson(response.responseData).productDetails.first;
    } else {
      isSuccess = false;
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
