import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zechat/helper/WebService/webServiceConstant.dart';
import 'package:zechat/helper/constant/sharedprefrensckey.dart';
import 'package:zechat/helper/sherdprefrence/sharedprefrenc.dart';

class UnFriendController extends GetxController{

  int lengthoflist=0;
  List<bool> isSendFriend =List.generate(12 , (index) => false);
  Future GetUnfriendList()async{
    String access_token =  CacheHelper.getData(key: access_tokenkey);
    var headers = {
      'Authorization': 'Bearer ${access_token}'
    };
    try{
      Dio dio = Dio();
      var  response = await dio.get('${apiurl}${apiunfriendList}',
        options: Options(
          headers: headers,
          validateStatus: (status) => true,
        ),
      );
      if (response.statusCode == 200) {
        print(response.data);
        lengthoflist = response.data['data'].length;
      }
      else {
        print(response.statusMessage);
      }
      return response.data;
    }catch(e){
      print(e);
    }
  }


  SendFrintRequest(id,index)async{

    isSendFriend[index]= true;
    print(isSendFriend[index]);
    update();
    // /*

    String access_token =  CacheHelper.getData(key: access_tokenkey);
    var headers = {
      'Authorization': 'Bearer ${access_token}'
    };
    var data = {
      'receiver_id': '${id}'
    };
    try{
      Dio dio = Dio();
      var  response = await dio.post('${apiurl}${apisendFriendrequest}',
        options: Options(
          headers: headers,
          validateStatus: (status) => true,
        ),
        data: data
      );
      if (response.statusCode == 200) {
        print(response.data);
      }
      else {
        print(response.statusMessage);
      }
      return response.data;
    }catch(e){
      print(e);
    }

     // */
  }


}