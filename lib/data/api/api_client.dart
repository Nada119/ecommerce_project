import 'package:ecommerce_project/utils/app_constants.dart';
import 'package:get/get.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token; //intialized in api client
  final String appBaseUrl; //server url
  late Map<String, String> _mainHeaders; //storing data locally
  //late SharedPreferences sharedPreferences;

  ApiClient({required this.appBaseUrl}) {
    //this.token = token;
    token = AppConstants.TOKEN;
    //token = sharedPreferences.getString(AppConstants.TOKEN) ?? "";
    baseUrl = appBaseUrl;
    timeout = Duration(seconds: 30);
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8', // get request
      'Authorization': 'Bearer $token',
    };
  }
  //very simple request
  Future<Response> getData(String uri, {Map<String, String>? headers}) async {
    try {
      Response response = await get(uri,
          headers: headers ??
              _mainHeaders); //get data then wait then save it in response
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}
