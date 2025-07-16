import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_mannager/data/model/user_model.dart';
class AuthController{

  static UserModel? userModel;
  static String? userToken;
  static Future<void>saveUserData(UserModel model, String token)async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    await sharedPreferences.setString("user-data", jsonEncode(model.toJson()));
    await sharedPreferences.setString("token",token);
    userModel=model;
    userToken=token;
  }
  static Future<void>getUserData()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    userModel=UserModel.formJson(jsonDecode(sharedPreferences.getString('user-data')!));
    userToken=sharedPreferences.getString('token');
  }
  static Future<void>clearData()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }
}