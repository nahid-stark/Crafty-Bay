import 'package:crafty_bay/data/models/review.dart';

class ReviewModel {
  String msg = "";
  List<Review> reviewList = [];

  ReviewModel.fromJson(Map<String, dynamic> json) {
    msg = json["msg"];
    if(json["data"] != null) {
      json["data"].forEach(
          (value){
            reviewList.add(Review.fromJson(value));
          },
      );
    }
  }
}