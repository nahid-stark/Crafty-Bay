class CartModel {
  final int productId;
  final String color;
  final String size;

  CartModel({
    required this.productId,
    required this.color,
    required this.size,
  });

  Map<String, dynamic> toJson() {
    return {
      "product_id":productId,
      "color":color,
      "size":size
    };
  }
}
