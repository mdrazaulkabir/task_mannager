import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:task_mannager/app.dart';
import 'package:task_mannager/ui/controller/auth_controller.dart';
import 'package:task_mannager/ui/screeen/sign_in_screen.dart';



class NetworkResponse {
  final bool isSuccess;
  final int statusCode;
  final Map<String, dynamic>? body;
  final String ? errorMessage;

  NetworkResponse(
      {required this.isSuccess, required this.statusCode, this.body, this.errorMessage});
}




class NetworkCaller {
  static const String _errorMessage="something went wrong";
  static const String _unAuthorizeMessage="something went wrong authorize ";


  static Future<NetworkResponse> getRequest({required String url}) async {
   try{
     Uri uri = Uri.parse(url);

     final Map<String,String> headers={
       "token": AuthController.accessToken??''
     };

     _logRequest(url, null, headers);
     Response response = await get(uri,headers:headers);
     _logResponse(url, response);

     if (response.statusCode == 200) {
       final decodedJson = jsonDecode(response.body);
       return NetworkResponse(isSuccess: true, statusCode: response.statusCode, body: decodedJson);
     } else if(response.statusCode==401){
       _onUnauthorize();
       return NetworkResponse(
           isSuccess: false, statusCode: response.statusCode, errorMessage: _unAuthorizeMessage);
     } else {
       final decodedJson=jsonDecode(response.body);
       return NetworkResponse(
           isSuccess: false, statusCode: response.statusCode, errorMessage: decodedJson['data']?? _errorMessage);
     }
   }
   catch(e){
         return NetworkResponse(
             isSuccess: false, statusCode: -1, errorMessage: e.toString());
       }
  }



  static Future<NetworkResponse> postRequest({required String url, Map<String,String>?body, Map<String,String>?headers, bool isFormLogin=false}) async {
    try{

      Uri uri = Uri.parse(url);
      final Map<String, String> headers = {
        "content-type": "application/json",
        "token": AuthController.accessToken ?? ''
      };

      _logRequest(url, body,headers);
      Response response = await post(
          uri,
          headers: headers,
          body: jsonEncode(body)
      );
      _logResponse(url, response);


      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(isSuccess: true, statusCode: response.statusCode, body: decodedJson);
      }
      else if (response.statusCode == 401) {
        if (isFormLogin == false) {
          _onUnauthorize();
        }
        return NetworkResponse(isSuccess: false, statusCode: response.statusCode, errorMessage: _unAuthorizeMessage);
      }
      else {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: decodedJson['data'] ?? _errorMessage);
      }
    }
    catch(e){
      return NetworkResponse(
          isSuccess: false, statusCode: -1, errorMessage: e.toString());
    }
  }




  //only for test
 static void _logRequest(String url, Map<String , String>? body,Map<String,String>? headers){
    debugPrint(
      '"""""""""""Request""""""""""""\n'
          'url: """"""$url\n'
          'Headers:"""$headers\n'
          'body: """""$body\n'
          '""""""""""""""""""""""""""""""""\n'
    );
  }

  static void _logResponse(String url, Response response){
    debugPrint(
        '""""""""""""""""""""""""Response"""""""""""""""""""\n'
            'url:"""""""""""""""$url\n'
            'Status Code:""""""""${response.statusCode}\n'
            'body: """""""""""""${response.body}\n'
            '"""""""""""""""""""""""""""""""""""""""""""""""""""\n'
    );
  }

 static Future<void>_onUnauthorize()async{
    await AuthController.clearData();
    Navigator.of(TaskManagerApp.navigator.currentContext!).pushNamedAndRemoveUntil(SignInScreen.name, (route) => false);
  }

}