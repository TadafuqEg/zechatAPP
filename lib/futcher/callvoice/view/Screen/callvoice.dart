import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zechat/futcher/call/controller/callController.dart';
import 'package:zechat/futcher/callvoice/controller/callvoiceController.dart';
import 'package:zechat/utils/appBrain.dart';

class VoiceCallScreen extends StatefulWidget {
  const VoiceCallScreen({super.key});

  @override
  State<VoiceCallScreen> createState() => _VoiceCallScreenState();
}

class _VoiceCallScreenState extends State<VoiceCallScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CallVoiceController(),
      builder: (controller) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          scaffoldMessengerKey: controller.scaffoldMessengerKey,
          home: Scaffold(

            body: Stack(
              children: [
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.cyan, Colors.blue.shade900],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                Center(
                    child:! controller.isJoined?Text(
                        'Calling ...',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.w900,fontSize: 25),
                    ):controller.remotUid == null?Text('Waiting for a remote user to join...',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.w900,fontSize: 25),):Text('Connected to remote user, uid:${controller.remotUid}',textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.w900,fontSize: 25),)
                ),
                controller.isJoined?Positioned(
                    bottom: 20,
                    right: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(onPressed: (){
                          controller.toggleMic();
                        },icon: controller.isMicMuted?Icon(Icons.mic_off):Icon(Icons.mic,color: Colors.white,size: 35,),),
                        SizedBox(width:18 ,),
                        IconButton(onPressed: (){controller.leave();},icon: Icon(Icons.call_end,color: Colors.red,size: 35,),),
                      ],
                    )):Container()
              ],
            ),
          ),
        );
      }
    );
  }
}

/*
ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              children: [
                Container(
                  height: 240,
                  decoration: BoxDecoration(border: Border.all()),
                  child: controller.isJoined? AgoraVideoView(
                    controller: VideoViewController(
                      rtcEngine: controller.agoraEngine,
                      canvas: VideoCanvas(uid: 0),
                    ),
                  ):Text(
                    'Join a channel',
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 240,
                  decoration: BoxDecoration(border: Border.all()),
                  child: Center(child:
                  controller.remotUid !=null?
                  AgoraVideoView(
                    controller: VideoViewController.remote(
                      rtcEngine: controller.agoraEngine,
                      canvas: VideoCanvas(uid: controller.remotUid),
                      connection: RtcConnection(channelId: AgoraManger.channelName),
                    ),
                  ): controller.isJoined? Text('Waiting for a remote user to join',textAlign: TextAlign.center,):Text('')
                  ),
                ),
                ElevatedButton(onPressed: (){
                  controller.join();
                }, child: Text('join')),
                ElevatedButton(onPressed: (){
                  controller.leave();
                }, child: Text('Leave'))

              ],
            ),
 */