import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zechat/futcher/call/controller/callController.dart';
import 'package:zechat/utils/appBrain.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CallController(),
      builder: (controller) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          scaffoldMessengerKey: controller.scaffoldMessengerKey,
          home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.red[900],
              leadingWidth: 100,
              title: Text('Index'),),
            body: Stack(
              children: [
                Container(
                  height: double.infinity,
                  decoration: BoxDecoration(border: Border.all(),color: Colors.black12),
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
                Positioned(
                  top: 20,
                  right: 20,
                  child: Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),),
                    child: controller.isJoined? AgoraVideoView(
                      controller: VideoViewController(
                        rtcEngine: controller.agoraEngine,
                        canvas: VideoCanvas(uid: 0,),
                      ),
                    ):Center(
                      child: Text(
                        '',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ) ,
                  ),
               /*
                controller.isJoined?Container(): Positioned(
                    top: 20,
                    left: 20,
                    child: IconButton(onPressed: (){controller.join();},icon: Icon(Icons.start,color: Colors.green,size: 35,),)),
                */
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
                        IconButton(onPressed: (){
                          controller.toggleCamera();
                        }, icon:controller.isCameraOn?Icon(Icons.camera_alt,color: Colors.white,size: 35,):Icon(Icons.camera_alt,color: Colors.black,size: 35,),),
                        SizedBox(width:18 ,),

                        IconButton(onPressed: (){
                          controller.switchCamera();
                        }, icon: Icon(Icons.flip_camera_ios,color: controller.isSwitched?Colors.blue:Colors.white,size: 35,)),
                        SizedBox(width:18 ,),
                        IconButton(onPressed: (){controller.leave();},icon: Icon(Icons.call_end,color: Colors.red,size: 35,),),
                      ],
                    )):Container()
              ],
            )
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