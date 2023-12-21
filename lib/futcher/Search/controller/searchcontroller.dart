import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:zechat/futcher/Search/model/searchmodel.dart';
import 'package:zechat/futcher/unfriendList/model/unfriendModel.dart';
import 'package:zechat/helper/WebService/webServiceConstant.dart';
import 'package:zechat/helper/constant/sharedprefrensckey.dart';
import 'package:zechat/helper/sherdprefrence/sharedprefrenc.dart';

class SearchedController extends GetxController {
  var queryAwal = [];
  var tempSearch = [];
  TextEditingController searchTec = TextEditingController();
  SearchModel searchModel = SearchModel();
  searchbtn()async{
    // tempSearch.clear();
    print('object');
    String access_token =  CacheHelper.getData(key: access_tokenkey);
    var headers = {
      'Authorization': 'Bearer ${access_token}'
    };
    try{
      Dio dio = Dio();
      var  response = await dio.get('${apiurl}${apisearch}?name_or_email=${searchTec.text}',
        options: Options(
          headers: headers,
          validateStatus: (status) => true,
        ),
      );
      if (response.statusCode == 200) {
        print(response.data);
        searchModel = SearchModel.fromJson(response.data);
        // print('sa${tempSearch.toString()}');
        update();


      }
      else {
        print(response.statusMessage);
      }
      update();
      return response.data;

    }catch(e){}
    update();
  }

  // /*
  void searchFriend(String data)async{
    print(data);
    String access_token =  CacheHelper.getData(key: access_tokenkey);
    var headers = {
      'Authorization': 'Bearer ${access_token}'
    };
    try{
      Dio dio = Dio();
      var  response = await dio.get('${apiurl}${apisearch}?name_or_email=${data}',
        options: Options(
          headers: headers,
          validateStatus: (status) => true,
        ),
      );
      if (response.statusCode == 200) {
        print(response.data);
        SearchModel searchModel = SearchModel();
        searchModel = SearchModel.fromJson(response.data);
        tempSearch=searchModel.data!;

      }
      else {
        print(response.statusMessage);
      }
      update();
      return response.data;

    }catch(e){}
  }

   // */
}
