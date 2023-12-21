import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseApi{


  final _firebaseMessaging = FirebaseMessaging.instance;
  Future<void> initNotification()async{
    await _firebaseMessaging.requestPermission();

    final fCMToke= await _firebaseMessaging.getToken();
    print('token ${fCMToke}');
  }
}