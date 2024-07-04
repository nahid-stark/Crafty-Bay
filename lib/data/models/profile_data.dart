class ProfileData {
  String? firstName;
  String? lastName;
  String? mobile;
  String? city;
  String? shippingAddress;

  ProfileData({
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.city,
    required this.shippingAddress,
  });
  ProfileData.fromJson(Map<String, dynamic> json) {
    firstName = json["firstName"];
    lastName = json["lastName"];
    mobile = json["mobile"];
    city = json["city"];
    shippingAddress = json["shippingAddress"];
  }
}
