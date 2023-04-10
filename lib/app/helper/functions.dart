import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  static String userLoggedInkey  = "USERLOGGEDINKEY";

  static saveUserLoggedInDetails({required bool isLoggedIn}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(userLoggedInkey, isLoggedIn);
  }

  static Future<bool?> getLoggedUserDetails()async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
   return  prefs.getBool(userLoggedInkey);
  }
}
