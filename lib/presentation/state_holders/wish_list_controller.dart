import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/models/product.dart';
import 'package:crafty_bay/data/models/wish_list_model.dart';
import 'package:crafty_bay/data/network_caller/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class WishListController extends GetxController {
  bool _inProgress = false;
  String _errorMessage = "";

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage;
  List<int> productIdList = [];
  List<Product> wishProductList = [];

  Future<bool> getWishList() async {
    productIdList.clear();
    wishProductList.clear();
    late bool isSuccess;
    _inProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(url: Urls.wishList);
    if (response.isSuccess) {
      productIdList = WishListModel.getProductIdList(response.responseData).productIdList;
      for (int index = 0; index < productIdList.length; index++) {
        final NetworkResponse productDetailsByIdResponse = await NetworkCaller.getRequest(
          url: Urls.productDetailsById(productIdList[index]),
        );
        wishProductList.add(Product.fromJson(productDetailsByIdResponse.responseData["data"][0]["product"]));
      }
      isSuccess = true;
    } else {
      isSuccess = false;
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
