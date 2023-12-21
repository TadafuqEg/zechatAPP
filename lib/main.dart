import 'dart:convert';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zechat/helper/sherdprefrence/sharedprefrenc.dart';
import 'package:zechat/utils/firebase_api.dart';
import 'package:zego_zimkit/zego_zimkit.dart';
import 'PageRoute/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'helper/constant/sharedprefrensckey.dart';
import 'utils/appBrain.dart';

bool? islogin;

Future<void> backgroundHandler(RemoteMessage message)async{
  String? title = message.notification!.title;
  String ?body = message.notification!.body;
  Map ? data = message.data;
  Map bodydata = json.decode(body!) ;
  if(bodydata['type']=="new_message"){
    AwesomeNotifications().createNotification(
      content:NotificationContent(
          id: 321,
          channelKey: "new_message",
          color: Colors.white,
          title: title,
          body: bodydata['message'],
          category: NotificationCategory.Social,
          wakeUpScreen: true,
          fullScreenIntent: true,
          autoDismissible: false,
          backgroundColor: Colors.redAccent
      ),
    );
  }else{
  AwesomeNotifications().createNotification(content: NotificationContent(id: 123, channelKey: "call_channel",
      color: Colors.white,
      title: title,
      body: bodydata['message'],
      category: NotificationCategory.Call,
      wakeUpScreen: true,
      fullScreenIntent: true,
      autoDismissible: false,
      backgroundColor: Colors.orangeAccent
  ),
  );
  }
}
void main() async{

  AwesomeNotifications().initialize(null, [
    NotificationChannel(channelKey: "friend_requset", channelName: "Call Channel", channelDescription: "channel of calling",
        defaultColor: Colors.red.shade600,
        ledColor: Colors.greenAccent,
        importance: NotificationImportance.Max,
        channelShowBadge: true,
        locked: true,
        defaultRingtoneType:  DefaultRingtoneType.Ringtone
    ),
    NotificationChannel(channelKey: "new_message", channelName: "Call Channel", channelDescription: "channel of calling",
        defaultColor: Colors.red.shade600,
        ledColor: Colors.yellow,
        importance: NotificationImportance.Max,
        channelShowBadge: true,
        locked: true,
        defaultRingtoneType:  DefaultRingtoneType.Ringtone
    )
  ],

  );

  await ZIMKit().init(appID: ZimKitManger.appId,appSign: ZimKitManger.appSign, appSecret: ZimKitManger.ServerSecret,);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  await FirebaseApi().initNotification();
  await CacheHelper.init();
  islogin = CacheHelper.getData(key: isLoginkey);
  if(islogin == null||  islogin == false ){
    islogin = false;
    // update();
  }else{
    islogin =true;
    // update();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ZeChat',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
        initialRoute: !islogin!?Routes.LOGIN:Routes.HOMEVIEW,
        getPages: AppPages.routes
    );
  }
}

