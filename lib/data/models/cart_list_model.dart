import 'package:crafty_bay/data/models/cart_item.dart';

class CartListModel {
  String msg = "";
  List<CartItem> cartItemList = [];

  CartListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      json['data'].forEach(
        (value) {
          cartItemList.add(CartItem.fromJson(value));
        },
      );
    }
  }
}
