import 'dart:convert';
import 'package:flutter/cupertino.dart';
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
   try{
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
       catch(e){
         return NetworkResponse(
             isSuccess: false, statuscode: -1, errorMessage: e.toString());
       }
  }


  //static const String _erroMessage="something went wrong";
  Future<NetworkResponse> postRequest({required String url, Map<String,String>? body}) async {
    try{
      Uri uri = Uri.parse(url);


      Response response = await post(
          uri,
          headers: {
            "content-type":"application/json"
          },
          body: jsonEncode(body));


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
    catch(e){
      return NetworkResponse(
          isSuccess: false, statuscode: -1, errorMessage: e.toString());
    }
  }




  //only for test
 static void _logRequest(String url, Map<String , String>? body){
    debugPrint(
      '"""""""""""Request""""""""""""\n'
          'url: $url\n'
          'body: $body\n'
          '"""""""""""""""""""""""""\n'
    );
  }

  static void _logResponse(String url, Response response){
    debugPrint(
        '"""""""""""Response""""""""""""\n'
            'url: $url\n'
            'body: $response\n'
            '""""""""""""""""""""""""""""\n'
    );
  }

}