import 'dart:convert';
import 'package:http/http.dart' as http;

class BaseResponse {
  String message;
  bool success;
  dynamic map;
  BaseResponse(this.message, this.success, this.map);

  static BaseResponse from(http.Response response) {
    dynamic data, error;
    try {
      data = jsonDecode(response.body);
    } catch (e) {
      print(response.body);
      error = e;
      print(e);
    }
    return BaseResponse(
        (data['message'] != null)
            ? data['message']
            : error?.toString() ?? 'Unknown Error!',
        (data['success'] != null) ? data['success'] : false,
        data);
  }
}
