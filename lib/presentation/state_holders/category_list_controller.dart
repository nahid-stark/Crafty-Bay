import 'package:crafty_bay/data/models/category_list_data.dart';
import 'package:crafty_bay/data/models/category_list_model.dart';
import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/network_caller/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class CategoryListController extends GetxController {
  bool _inProgress = false;
  String _errorMessage = "";
  List<CategoryListData> _categoryListItems = <CategoryListData>[];

  bool get inProgress => _inProgress;

  List<CategoryListData> get categoryListItems => _categoryListItems;

  String get errorMessage => _errorMessage;

  Future<bool> getCategoryListData() async {
    late bool isSuccess;
    _inProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(url: Urls.categoryList);
    if (response.isSuccess) {
      isSuccess = true;
      _categoryListItems = CategoryListModel.fromJson(response.responseData).categoryListItems;
    } else {
      isSuccess = false;
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
