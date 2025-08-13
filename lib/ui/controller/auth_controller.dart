import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_mannager/data/model/user_model.dart';
class AuthController{

  static UserModel? userModel;
  static String? accessToken;

  static const String _userDataKey="user-data";
  static const String _userTokenKey="token";

  static Future<void>saveUserData(UserModel model, String token)async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    await sharedPreferences.setString(_userDataKey, jsonEncode(model.toJson()));
    await sharedPreferences.setString(_userTokenKey,token);
    userModel=model;
    accessToken=token;
  }

  static Future<void>updateData(UserModel model)async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    await sharedPreferences.setString(_userDataKey, jsonEncode(model.toJson()));
    userModel=model;
  }

  static Future<void>getUserData()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    userModel=UserModel.formJson(jsonDecode(sharedPreferences.getString('user-data')!));
    accessToken=sharedPreferences.getString('token');
  }

  static Future<bool>isUserLogin()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    String? token=sharedPreferences.getString('token');
    if(token !=null){
      await getUserData();
      return true;
    }
    else{
      return false;
    }
  }


  static Future<void>clearData()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    userModel=null;
    accessToken=null;
  }
}