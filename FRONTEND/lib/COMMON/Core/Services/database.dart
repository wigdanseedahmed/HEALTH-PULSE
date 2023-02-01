///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class DatabaseMethods with ChangeNotifier {
  var log = Logger();
  FlutterSecureStorage storage = const FlutterSecureStorage();

  getUserInfo(String email) async {
    String? token = await storage.read(key: "token");


    var response = await http.get(
      Uri.parse(AppUrl.getUsers),
      headers: {
        "Authorization": "Bearer $token",
        //"Accept": "application/json",
        "Access-Control-Allow-Origin": "*",
        // Required for CORS support to work
        //"Access-Control-Allow-Credentials": 'true', // Required for cookies, authorization headers with HTTPS
        "Access-Control-Allow-Headers":
        "Content-Type, Access-Control-Allow-Origin, Accept",
        "Access-Control-Allow-Methods": "POST, DELETE, GET, PUT, PATCH"
      },

    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      log.i(response.body);

      //UserModel authUser = UserModel.fromJson(json.decode(response.body));
      //UserPreferences().saveUser(authUser);

      return json.decode(response.body);
    }
    log.i(response.body);
    log.i(response.statusCode);
  }

  getUserByUserEmail(String userEmail) async {
    String? token = await storage.read(key: "token");

    var response = await http.get(
      Uri.parse("${AppUrl.checkEmailExists}$userEmail"),
      headers: {
        "Authorization": "Bearer $token",
        //"Accept": "application/json",
        "Access-Control-Allow-Origin": "*",
        // Required for CORS support to work
        //"Access-Control-Allow-Credentials": 'true', // Required for cookies, authorization headers with HTTPS
        "Access-Control-Allow-Headers":
        "Content-Type, Access-Control-Allow-Origin, Accept",
        "Access-Control-Allow-Methods": "POST, DELETE, GET, PUT, PATCH"
      },

    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      log.i(response.body);

      //UserModel authUser = UserModel.fromJson(json.decode(response.body));
      //UserPreferences().saveUser(authUser);

      return json.decode(response.body);
    }
    log.i(response.body);
    log.i(response.statusCode);
  }

  updateUserInformationByEmail(UserModel user) async {
    String? token = await storage.read(key: "token");


    var response = await http.put(
      Uri.parse("${AppUrl.updateUserInformationByEmail}${user.email}"),
      headers: {
        "Authorization": "Bearer $token",
        //"Accept": "application/json",
        "Access-Control-Allow-Origin": "*",
        // Required for CORS support to work
        //"Access-Control-Allow-Credentials": 'true', // Required for cookies, authorization headers with HTTPS
        "Access-Control-Allow-Headers":
        "Content-Type, Access-Control-Allow-Origin, Accept",
        "Access-Control-Allow-Methods": "POST, DELETE, GET, PUT, PATCH"
      },

    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      log.i(response.body);

      //UserModel authUser = UserModel.fromJson(json.decode(response.body));
      //UserPreferences().saveUser(authUser);

      return json.decode(response.body);
    }
    log.i(response.body);
    log.i(response.statusCode);
  }

  updateUserPasswordByUsername(UserModel user) async {
    String? token = await storage.read(key: "token");


    var response = await http.put(
      Uri.parse("${AppUrl.updateUserInformationByEmail}${user.username}"),
      headers: {
        "Authorization": "Bearer $token",
        //"Accept": "application/json",
        "Access-Control-Allow-Origin": "*",
        // Required for CORS support to work
        //"Access-Control-Allow-Credentials": 'true', // Required for cookies, authorization headers with HTTPS
        "Access-Control-Allow-Headers":
        "Content-Type, Access-Control-Allow-Origin, Accept",
        "Access-Control-Allow-Methods": "POST, DELETE, GET, PUT, PATCH"
      },

    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      log.i(response.body);

      //UserModel authUser = UserModel.fromJson(json.decode(response.body));
      //UserPreferences().saveUser(authUser);

      return json.decode(response.body);
    }
    log.i(response.body);
    log.i(response.statusCode);
  }
}

class HelperFunctions {
  static String sharedPreferenceUserKey = "ISLOGGEDIN";
  static String sharedPreferenceUserNameKey = "USERNAMEKEY";
  static String sharedPreferenceUserEmailKey = "USEREMAILKEY";

  static Future<bool> saveUserLoggedInPreference(bool userLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferenceUserKey, userLoggedIn);
  }

  static Future<bool> saveUserNamePreference(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserNameKey, userName);
  }

  static Future<bool> saveUserEmailPreference(String userEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserEmailKey, userEmail);
  }

  static Future<bool?> getUserLoggedInPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(sharedPreferenceUserKey);
  }

  static Future<String?> getUserNamePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferenceUserNameKey);
  }

  static Future<String?> getUserEmailPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferenceUserEmailKey);
  }
}
