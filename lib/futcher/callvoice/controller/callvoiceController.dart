import 'dart:math';
import 'dart:ui';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';


// import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:zechat/utils/appBrain.dart';
// import 'package:agora_rtc_engine/rtc_engine.dart';


class CallVoiceController extends GetxController{



  @override
  void dispose() async{
    // TODO: implement dispose
    await agoraEngine.leaveChannel();
    agoraEngine.release();
    super.dispose();
  }

  Future<void> handleCameraandMic(Permission permission)async {
    final status = await permission.request();
    print(status.toString());
  }
  int uid = 0; // uid of the local user
  int ? remotUid;
  bool isJoined = false;
  bool isSwitched = false;
  bool isMicMuted = false;
  bool isCameraOn = true;
  late RtcEngine agoraEngine;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  showMessage(String message) {
    scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
  Future<void> setupVoiceSDKEngine() async{
    await [Permission.microphone].request();
    agoraEngine = createAgoraRtcEngine();
    await agoraEngine.initialize( RtcEngineContext(
        appId: AgoraManger.appId,
    ));
    agoraEngine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          showMessage("Local user uid:${connection.localUid} joined the channel");
          isJoined = true;
          update();
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          showMessage("Remote user uid:$remoteUid joined the channel");
          remotUid = remoteUid;
          update();
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          showMessage("Remote user uid:$remoteUid left the channel");
            remotUid = null;
            update();
        },
      ),
    );
    join();
  }


  String serverUrl = "";
  final channelController= TextEditingController();
  int tokenExpireTime = 45; // Expire time in Seconds.
  bool isTokenExpiring = false; //
  // late RtcEngine engine;

  @override
  void onInit() async {
    print("call onInit");
   // initAgora();
   //  setupVideoSDKEngine();
    setupVoiceSDKEngine();
    super.onInit();
  }
  final Map<String, RtcEngine> callEngines = {};
  Future<String> createCall(int user1Id, int user2Id) async {
    // Generate unique channel name.
    final channelName = "call-${Random().nextInt(10000)}";
    
    // Create new engine for this call.
    final engine = createAgoraRtcEngine();
    ChannelMediaOptions options = const ChannelMediaOptions(
      clientRoleType: ClientRoleType.clientRoleBroadcaster,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    );
    // Join the channel with both user IDs.
    await engine.initialize(const RtcEngineContext(appId: "e2238ce0bb2042b2a61856f6269b5c8b", channelProfile: ChannelProfileType.channelProfileLiveBroadcasting));
    await engine.joinChannel(token: "<your_token>", channelId: channelName, uid: user1Id, options: options);
    await engine.joinChannel(token: "<your_token>", channelId: channelName, uid: user2Id, options: options);

    // Add engine and channel to map.
    callEngines[channelName] = engine;

    return channelName;
  }

// Function to end a call and dispose of its engine.
  void endCall(String channelName) async {
    final engine = callEngines.remove(channelName);
    if (engine != null) {
      await engine.leaveChannel();
      // await engine.destroy();
    }
  }

  void  join() async {
    await agoraEngine.startPreview();
    isJoined = true;
    // Set channel options including the client role and channel profile
    ChannelMediaOptions options = const ChannelMediaOptions(
      clientRoleType: ClientRoleType.clientRoleBroadcaster,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    );
    await agoraEngine.joinChannel(
      token: AgoraManger.token,
      channelId: '${AgoraManger.channelName}',
      options: options,
      uid: uid,
    );
    update();
  }
  void leave() {
   isJoined=false;
   remotUid = null;
   update();
    agoraEngine.leaveChannel();
    Get.back();
  }
  void switchCamera(){
    agoraEngine.switchCamera();
    isSwitched =!isSwitched;
    update();
  }
  void toggleMic(){
    agoraEngine.muteLocalAudioStream(!isMicMuted);
    isMicMuted = !isMicMuted;
    update();
  }
  void toggleCamera() {
    agoraEngine.enableLocalVideo(!isCameraOn);
      isCameraOn = !isCameraOn;
      update();
  }
  Future<String> createChannel(String user1Id, String user2Id)async{
    final random = Random();
    final channelName = "call-${random.nextInt(10000)}";

    return channelName;
  }




}



