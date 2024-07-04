import 'package:crafty_bay/data/models/profile_data.dart';

class Review {
  int? id;
  String? description;
  String? email;
  int? productId;
  ProfileData? profileData;

  Review({
    required this.id,
    required this.description,
    required this.email,
    required this.productId,
    required this.profileData,
  });

  Review.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    description = json["description"];
    email = json["email"];
    productId = json["product_id"];
    profileData = ProfileData.fromJson(json["profile"]);
  }
}
