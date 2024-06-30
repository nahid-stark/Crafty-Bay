import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/network_caller/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class ReadProfileController extends GetxController {
  bool _inProgress = false;
  String _errorMessage = "";
  bool get inProgress => _inProgress;
  String get errorMessage => _errorMessage;

  Future<bool> readProfile() async {
    late bool isSuccess;
    _inProgress = true;
    final NetworkResponse response = await NetworkCaller.getRequest(url: Urls.readProfile);
    if (response.isSuccess && response.responseData["data"] != []) {
      isSuccess = true;
    } else {
      isSuccess = false;
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    return isSuccess;
  }
}