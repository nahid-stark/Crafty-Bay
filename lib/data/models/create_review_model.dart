class CreateReviewModel {
  final String description;
  final int productId;

  CreateReviewModel({
    required this.description,
    required this.productId,
  });

  Map<String, dynamic> toJson() {
    return {
      "description" : description,
      "product_id" : productId,
    };
  }
}
