import 'package:crafty_bay/data/models/cart_item.dart';
import 'package:crafty_bay/data/models/cart_list_model.dart';
import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/models/product.dart';
import 'package:crafty_bay/data/network_caller/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class CartListController extends GetxController {
  bool _inProgress = false;
  String _errorMessage = "";
  int cartListTotalPrice = 0;

  bool get inProgress => _inProgress;
  String get errorMessage => _errorMessage;

  List<CartItem> _cartItemList = <CartItem>[];
  List<CartItem> get cartItemList => _cartItemList;

  List<int> productIdList = [];
  List<Product> cartProductList = [];

  Future<bool> getCartList() async {
    productIdList.clear();
    cartProductList.clear();
    late bool isSuccess;
    _inProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(url: Urls.cartList);
    if (response.isSuccess) {
      productIdList = CartListModel.getProductIdList(response.responseData).productIdList;
      print(productIdList);
      for (int index = 0; index < productIdList.length; index++) {
        final NetworkResponse productDetailsByIdResponse = await NetworkCaller.getRequest(
          url: Urls.productDetailsById(productIdList[index]),
        );
        cartProductList.add(Product.fromJson(productDetailsByIdResponse.responseData["data"][0]["product"]));
      }
      isSuccess = true;
      _cartItemList = CartListModel.fromJson(response.responseData).cartItemList;
      cartListTotalPrice = totalPrice().toInt();
    } else {
      isSuccess = false;
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }

  double totalPrice() {
    double total = 0;
    for (int index = 0; index < productIdList.length; index++) {
      total += (double.tryParse(_cartItemList[index].size?.split("-")[1] ?? "0") ?? 0) *
          (double.tryParse(cartProductList[index].price ?? "0") ?? 0);
    }
    return total;
  }
}
