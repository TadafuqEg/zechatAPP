import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:zechat/helper/WebService/webServiceConstant.dart';
import 'package:zechat/helper/constant/sharedprefrensckey.dart';
import 'package:zechat/helper/sherdprefrence/sharedprefrenc.dart';

class LoginController extends GetxController{

  TextEditingController emailTec = TextEditingController();
  String emailerror='';
  TextEditingController passwordTec = TextEditingController();
  String passworderror='';
  bool passwordobscureText = true;
  ShowPassword(){
    passwordobscureText?passwordobscureText=false:passwordobscureText= true;
    print(passwordobscureText);
    update();
  }
  String token ='';
  String errorMessage ='';
  bool   isLoading = false;
  Login()async{
    if(emailTec.text.isEmpty){
      emailerror = 'Enter email address';
      update();
    }else if(passwordTec.text.isEmpty){
      passworderror = 'Enter Password';
      update();
    }else{
      emailerror = '';
      passworderror = '';
      errorMessage ='';
      update();
      final firebaseMessaging = FirebaseMessaging.instance;
      final FCMtoken = await firebaseMessaging.getToken();
      token = '${FCMtoken}';
      Dio dio = Dio();
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      };
      var data = {
        'email': '${emailTec.text}',
        'password': '${passwordTec.text}',
        'FcmToken':'${token}'
      };

      try{
        isLoading = true;
        update();
        var response = await dio.post('${apiurl}${apilogin}',
            options: Options(
              headers: headers,
              validateStatus: (status) => true,
            ),
            data: data
        );
        print(response.statusCode);
        if (response.statusCode == 200) {
          print(response.data);
          if (response.data['success']== false){
            errorMessage = "Password is invaled";
            isLoading = false;
            update();
          }else{
            isLoading = false;
            update();
            CacheHelper.saveData(key: access_tokenkey, value: response.data['data']['access_token']);
            CacheHelper.saveData(key: emilkey, value: response.data['data']['email']);
            CacheHelper.saveData(key: isLoginkey, value: true);
            Get.toNamed('/homeview');
          }

        }
        else if(response.statusCode==422){
          print(response.data);
          errorMessage = response.data["message"];
          isLoading = false;
          update();

        }
        else{
          isLoading = false;
          errorMessage = response.data["message"];
          update();
          print(response.data);
        }

      }catch(e){
        print(e);
      }

    }
  }
}