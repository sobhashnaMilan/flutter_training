import 'package:http/http.dart' as http;
import '../utils/app_string.dart';
import '../utils/styles_utils.dart';
import 'ApiConfig.dart';

class ApiManager {
  static var client = http.Client();

  // user list APIs
  static userListCall({
    required onRequestTimeOut,
  }) async {
    flutterPrint(msg: "USERS URL -> $apiUsers");

    var response = await client.get(Uri.parse(apiUsers)).timeout(
          const Duration(seconds: timeoutDurationNormalAPIs),
          onTimeout: () => onRequestTimeOut(AppString().msgRequestTimeOut),
        );

    return response;
  }

  // add user APIs
  static userAddAPICall({
    required name,
    required job,
    required onRequestTimeOut,
  }) async {
    flutterPrint(msg: "API_USERS_NEW -> $apiUsersNew");

    /// pass data header or params
    // Map<String, String> header = {
    //   HttpHeaders.authorizationHeader: "$headerPreValue $token",
    //   TIMEZONE_KEY: timezone,
    // };

    /// pass post data
    Map<String, String> params = {"name": name, "job": job};

    flutterPrint(msg: "params $params");

    return client.post(Uri.parse(apiUsersNew), body: params).timeout(
          const Duration(seconds: timeoutDurationNormalAPIs),
          onTimeout: () => onRequestTimeOut(AppString().msgRequestTimeOut),
        );
  }
}
