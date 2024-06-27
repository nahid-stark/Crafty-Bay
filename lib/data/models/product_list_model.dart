import 'package:crafty_bay/data/models/product.dart';

class ProductListModel {
  String msg = "";
  List<Product> productList = <Product>[];

  ProductListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      json['data'].forEach(
        (value) {
          productList.add(Product.fromJson(value));
        },
      );
    }
  }
}
