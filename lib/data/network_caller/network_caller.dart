import 'dart:convert';
import 'dart:developer';
import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/presentation/screens/email_verification_screen.dart';
import 'package:get/get.dart' as get_x;
import 'package:http/http.dart';

class NetworkCaller {
  static Future<NetworkResponse> getRequest({required String url}) async {
    try {
      log(url);
      final Response response = await get(Uri.parse(url));
      log(response.statusCode.toString());
      log(response.body);
      if (response.statusCode == 200) {
        final dynamic decodedData = jsonDecode(response.body);
        return NetworkResponse(
          responseCode: response.statusCode,
          isSuccess: true,
          responseData: decodedData,
        );
      } else if (response.statusCode == 401) {
        ///TODO: handle 401 unauthorized user
        _goToSignInScreen();
        return NetworkResponse(
          responseCode: response.statusCode,
          isSuccess: false,
        );
      } else {
        return NetworkResponse(
          responseCode: response.statusCode,
          isSuccess: false,
        );
      }
    } catch (error) {
      log(error.toString());
      return NetworkResponse(
        responseCode: -1,
        isSuccess: false,
        errorMessage: error.toString(),
      );
    }
  }

  static Future<NetworkResponse> postRequest({required String url, Map<String, dynamic>? body}) async {
    try {
      log(url);
      final Response response = await post(Uri.parse(url), headers: {"accept" : "application/json"}, body: body);
      log(response.statusCode.toString());
      log(response.body);
      if (response.statusCode == 200) {
        final dynamic decodedData = jsonDecode(response.body);
        return NetworkResponse(
          responseCode: response.statusCode,
          isSuccess: true,
          responseData: decodedData,
        );
      } else if (response.statusCode == 401) {
        ///TODO: handle 401 unauthorized user
        _goToSignInScreen();
        return NetworkResponse(
          responseCode: response.statusCode,
          isSuccess: false,
        );
      } else {
        return NetworkResponse(
          responseCode: response.statusCode,
          isSuccess: false,
        );
      }
    } catch (error) {
      log(error.toString());
      return NetworkResponse(
        responseCode: -1,
        isSuccess: false,
        errorMessage: error.toString(),
      );
    }
  }

  static void _goToSignInScreen() {
    // Navigator.push(
    //   CraftyBay.navigationKey.currentState!.context,
    //   MaterialPageRoute(
    //     builder: (context) => const EmailVerificationScreen(),
    //   ),
    // );
    get_x.Get.to(() => const EmailVerificationScreen());
  }
}
