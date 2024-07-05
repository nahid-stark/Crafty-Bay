import 'package:crafty_bay/data/models/cart_item.dart';
import 'package:crafty_bay/data/models/cart_list_model.dart';
import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/network_caller/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class CartListController extends GetxController {
  bool _inProgress = false;
  String _errorMessage = "";
  bool get inProgress => _inProgress;
  String get errorMessage => _errorMessage;

  List<CartItem> _cartItemList = <CartItem>[];
  List<CartItem> get cartItemList => _cartItemList;

  Future<bool> getCategoryListData() async {
    late bool isSuccess;
    _inProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(url: Urls.cartList);
    if (response.isSuccess) {
      isSuccess = true;
      _cartItemList = CartListModel.fromJson(response.responseData).cartItemList;
    } else {
      isSuccess = false;
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
