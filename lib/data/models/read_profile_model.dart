import 'package:crafty_bay/data/models/profile_data.dart';

class ReadProfileModel {
  String msg = "";
  List<ProfileData> profileDataList = [];

  ReadProfileModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      json['data'].forEach(
        (value) {
          profileDataList.add(ProfileData.fromJson(value));
        },
      );
    }
  }
}
