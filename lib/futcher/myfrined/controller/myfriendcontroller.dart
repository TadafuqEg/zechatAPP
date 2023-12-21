import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zechat/helper/WebService/webServiceConstant.dart';
import 'package:zechat/helper/constant/sharedprefrensckey.dart';
import 'package:zechat/helper/sherdprefrence/sharedprefrenc.dart';

class MyFriendController extends GetxController{

  Future GetMyFriend(context)async{
    String access_token =  CacheHelper.getData(key: access_tokenkey);
    var headers = {
      'Authorization': 'Bearer ${access_token}'
    };
    try{
      Dio dio = Dio();
      var response = await dio.get(
        '${apiurl}${apiMyFriend}',
        options: Options(
          headers: headers,
          validateStatus: (status) => true,
        ),
      );
      if(response.statusCode == 200){
        print(response.data);
        return response.data;
      }else{
        print(response.data);
      }
    }catch(e){
      print(e);
    }

  }
}