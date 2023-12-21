import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dio/dio.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zechat/helper/WebService/webServiceConstant.dart';
import 'package:zechat/helper/constant/sharedprefrensckey.dart';
import 'package:zechat/helper/sherdprefrence/sharedprefrenc.dart';

class ChatRoomController extends GetxController {

  late BuildContext context;
  ChatRoomController({required this.context});
  late FocusNode focusNode;
   TextEditingController chatC = TextEditingController();

   SendMessage(id)async{
     String access_token =  CacheHelper.getData(key: access_tokenkey);
     var headers = {
       'Authorization': 'Bearer ${access_token}'
     };
     var data = {
       'receiver_id': '${id}',
       'message': '${chatC.text.trim()}'
     };
     try{
       Dio dio = Dio();
       var response = await dio.post('${apiurl}${apiSendMessage}',
       options: Options(
         headers: headers,
         validateStatus: (status) => true,
       ),
         data: data
       );
       if(response.statusCode == 200){
         print(response.data);
         chatC.text = '';
         update();
       }
     }catch(e){

     }

   }

   late String UserID ;
   Future GetMessage(id)async{
     String access_token =  CacheHelper.getData(key: access_tokenkey);
     var headers = {
       'Authorization': 'Bearer ${access_token}'
     };
     UserID = id;
     print("$UserID UserIDUserIDUserID");
     try{
       Dio dio = Dio();
       var response = await dio.get('${apiurl}user/get-messages/${id}',
           options: Options(
             headers: headers,
             validateStatus: (status) => true,
           ),

       );
       if(response.statusCode == 200){
         print(response.data);
         // update();
         return response.data;

       }
     }catch(e){

     }
   }
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      String? title = message.notification!.title;
      String ?body = message.notification!.body;
      print(body);
      Map ? data = message.data;
      print('Data ${data[message]}');
      print("Message ****\n ${message}");

      Map bodydata = json.decode(body!) ;
      print('type is ${bodydata['type']}');
      if(bodydata['type']=="new_message"){
        print('message is ${bodydata['message']}');
        print('sender id is ${bodydata['sender_id']}');
        /*
        AwesomeNotifications().createNotification(
          content:NotificationContent(
              id: 321,
              channelKey: "${bodydata['type']}",
              color: Colors.white,
              title: title,
              body: bodydata['message'],
              category: NotificationCategory.Social,
              wakeUpScreen: true,
              fullScreenIntent: true,
              autoDismissible: false,
              backgroundColor: Colors.redAccent
          ),
        );*/

        print("$UserID UserIDUserIDUserID");
        if(bodydata['sender_id'] == UserID){
          update();
        }else{
          ShowElegant_notification(
              body: bodydata['message'],
              titel: title,
              id: bodydata['sender_id'].toString(),
              name: bodydata['sender_name'].toString()

          );
          update();
        }
      }else{
        // Map bodydata = json.decode(body) ;
        ElegantNotification.info(
          height: 100,
          // toastDuration: Duration(seconds: 30),
          autoDismiss: false,
          showProgressIndicator: false,
          title:  Text("$title"),
          description:  Text("$bodydata['message'],"),
          action:Icon(Icons.double_arrow_sharp),
          onActionPressed: (){
            Get.toNamed('/receivedreqfriend');
          },
        ).show(context);

        /*
        AwesomeNotifications().createNotification(content: NotificationContent(
            id: 123,
            channelKey: "friend_requset",
            color: Colors.white,
            title: title,
            body: bodydata['message'],
            category: NotificationCategory.Reminder,
            wakeUpScreen: true,
            fullScreenIntent: true,
            autoDismissible: false,
            backgroundColor: Colors.orangeAccent
        ),
        );
 */
      }
    });


  }
  ShowElegant_notification({body,titel,id,name}){
    print('elegantNorificatio');
    ElegantNotification.info(
        height: 100,
        // toastDuration: Duration(seconds: 30),
        autoDismiss: false,
        showProgressIndicator: false,
        title:  Text("$titel"),
        description:  Text("$body"),
        action: IconButton(onPressed: () {
          Navigator.pop(context);
          Get.toNamed("/chat-room",
              arguments:
              {
                "id": "${id}",
                "name":name,
              }

          );
        }, icon: Icon(Icons.double_arrow_rounded),),
    ).show(context);
  }

    // Map args = Get.arguments;


  //    @override
  // void onInit() {
  //   // TODO: implement onInit
  //   //    id= args['id'];
  //   //    name = args['name'];
  //   //    email = args['email'];
  //   //    FcmToken = args['FcmToken'];
  //
  //   super.onInit();
  // }
}