import 'package:crafty_bay/data/models/product_details_model.dart';

class ProductDetailsWrapperModel {
  String msg = "";
  List<ProductDetailsModel> productDetails = <ProductDetailsModel>[];

  ProductDetailsWrapperModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      json['data'].forEach(
        (value) {
          productDetails.add(ProductDetailsModel.fromJson(value));
        },
      );
    }
  }
}
