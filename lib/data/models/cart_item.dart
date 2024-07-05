class CartItem {
  int? id;
  String? email;
  int? productId;
  String? color;
  String? size;
  String? createdAt;
  String? updatedAt;

  CartItem({
    this.id,
    this.email,
    this.productId,
    this.color,
    this.size,
    this.createdAt,
    this.updatedAt,
  });

  CartItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    productId = json['product_id'];
    color = json['color'];
    size = json['size'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
