import 'package:crafty_bay/data/models/category_list_data.dart';

class CategoryListModel {
  String msg = "";
  List<CategoryListData> categoryListItems = <CategoryListData>[];

  CategoryListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      json['data'].forEach(
        (value) {
          categoryListItems.add(CategoryListData.fromJson(value));
        },
      );
    }
  }
}
