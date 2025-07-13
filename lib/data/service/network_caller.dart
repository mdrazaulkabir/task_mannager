import 'dart:convert';

import 'package:http/http.dart';

class NetworkResponse {
  final bool isSuccess;
  final int statuscode;
  final Map<String, dynamic>? body;
  final String ? errorMessage;

  NetworkResponse(
      {required this.isSuccess, required this.statuscode, this.body, this.errorMessage});
}

class NetworkCaller {
  static const String _erroMessage="something went wrong";
  Future<NetworkResponse> getRequest({required String url}) async {
    Uri uri = Uri.parse(url);
    Response response = await get(uri);
    if (response.statusCode == 200) {
      final decodedJson = jsonDecode(response.body);
      return NetworkResponse(
          isSuccess: true, statuscode: response.statusCode, body: decodedJson);
    } else {
      final decodedJson=jsonDecode(response.body);
      return NetworkResponse(
          isSuccess: false, statuscode: response.statusCode, errorMessage: decodedJson['data']?? _erroMessage);

    }
  }
}