class Urls {
  static const String _baseUrl = "https://craftybay.teamrabbil.com/api";
  static const String homeScreenCarouselSlider = "$_baseUrl/ListProductSlider";
  static const String categoryList = "$_baseUrl/CategoryList";
  static String productListByCategory(int categoryId) => "$_baseUrl/ListProductByCategory/$categoryId";
  static String productListByRemark(String remark) => "$_baseUrl/ListProductByRemark/$remark";
}