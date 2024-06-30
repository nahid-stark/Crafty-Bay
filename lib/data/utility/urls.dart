class Urls {
  static const String _baseUrl = "https://craftybay.teamrabbil.com/api";
  static const String homeScreenCarouselSlider = "$_baseUrl/ListProductSlider";
  static const String categoryList = "$_baseUrl/CategoryList";
  static String productListByCategory(int categoryId) => "$_baseUrl/ListProductByCategory/$categoryId";
  static String productListByRemark(String remark) => "$_baseUrl/ListProductByRemark/$remark";
  static String productDetailsById(int productId) => "$_baseUrl/ProductDetailsById/$productId";
  static String verifyEmail(String email) => "$_baseUrl/UserLogin/$email";
  static String verifyOtp(String email, String otp) => "$_baseUrl/VerifyLogin/$email/$otp";
  static const String addToCart = "$_baseUrl/CreateCartList";
  static const String readProfile = "$_baseUrl/ReadProfile";
}