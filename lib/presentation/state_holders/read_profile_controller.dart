import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/models/profile_data.dart';
import 'package:crafty_bay/data/models/read_profile_model.dart';
import 'package:crafty_bay/data/network_caller/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class ReadProfileController extends GetxController {
  bool _inProgress = false;
  String _errorMessage = "";

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage;
  List<ProfileData> _profileDataList = [];

  List<ProfileData> get profileDataList => _profileDataList;

  Future<bool> readProfile() async {
    late bool isSuccess;
    _inProgress = true;
    update();
    await Future.delayed(const Duration(seconds: 5));
    final NetworkResponse response = await NetworkCaller.getRequest(url: Urls.readProfile, fromAuth: true);
    if (response.isSuccess) {
      _profileDataList = ReadProfileModel.fromJson(response.responseData).profileDataList;
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
