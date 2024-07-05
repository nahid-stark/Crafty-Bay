class WishListModel {
  String msg = "";
  List<int> productIdList = [];

  WishListModel.getProductIdList(Map<String, dynamic> json) {
    msg = json["msg"];
    if (json["data"] != null) {
      json["data"].forEach(
        (value) {
          productIdList.add(value["product_id"]);
        },
      );
    }
  }
}
