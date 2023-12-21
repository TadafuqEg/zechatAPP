import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  late BuildContext context;
  HomeController({required this.context});
  @override
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
                backgroundColor: Colors.red
            ),
        );*/

        ShowElegant_notification(
          body: bodydata['message'],
          titel: title,
          id: bodydata['sender_id'].toString(),
          name: bodydata['sender_name'].toString()
        );

        // update();

      }else{

      // AwesomeNotifications().createNotification(content: NotificationContent(
      //     id: 123,
      //     channelKey: "friend_requset",
      //     color: Colors.white,
      //     title: title,
      //     body: body,
      //     category: NotificationCategory.Reminder,
      //     wakeUpScreen: true,
      //     fullScreenIntent: true,
      //     autoDismissible: false,
      //     backgroundColor: Colors.orangeAccent
      // ),
      // );
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
      }
    });


  }

  ShowElegant_notification({body,titel,id,name}){
    print('elegantNorificatio');
    ElegantNotification(
        height: 100,
        // toastDuration: Duration(seconds: 30),
        autoDismiss: false,
        showProgressIndicator: false,
        title:  Text("$titel"),
      description:  Text("$body"),
      action:Icon(Icons.double_arrow_sharp),
      onActionPressed: (){
        Get.toNamed("/chat-room",
            arguments:
            {
              "id": "${id}",
              "name":name,
            }

        );
      }, icon: Icon(Icons.chat),
    ).show(context);
  }
}

