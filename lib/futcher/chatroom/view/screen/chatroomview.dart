import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zechat/futcher/chatroom/controller/chat_room_controller.dart';
import 'package:zechat/futcher/chatroom/view/widgets/textTypeChat/textTypeChat.dart';
import 'package:zechat/helper/color.dart';
import 'package:zechat/helper/constant/scalesize.dart';
import 'package:intl/intl.dart';

class ChatRoomView extends StatelessWidget {
  const ChatRoomView({super.key});

  @override
  Widget build(BuildContext context) {
    var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    final  args = Get.arguments;
    String name=args['name'];
    String id=args['id'].toString();

    return GetBuilder(
        init:ChatRoomController(context: context) ,
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: kPrimaryColor,
            leading:IconButton(onPressed: (){
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios_new,color: Colors.white,),
            ) ,
            centerTitle: false,
            title: Row(

              children: [

                Text('${name}',
                  style: TextStyle(color: Colors.white,),
                ),
              ],
            ),
            actions: [
              IconButton(icon:Icon(Icons.call,color: Colors.white,),onPressed: (){
                Get.toNamed('/voicecallPage');
              },),IconButton(icon:Icon(Icons.video_call,color: Colors.white,),onPressed: (){
                Get.toNamed('/indexPage');
              },),
            ],
          ),
          body: Column(
            children: [
              Expanded(child: Container(child: FutureBuilder(
                future: controller.GetMessage(id),
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    var alldata = snapshot.data;
                    return ListView.builder(
                      reverse: true,
                      itemCount:alldata["data"].length,
                    itemBuilder:(context,index){
                      return Column(
                        crossAxisAlignment: alldata["data"][index]['receiver_id']!=id?CrossAxisAlignment.end:CrossAxisAlignment.start,
                        children: [
                      Container(
                        margin: EdgeInsets.only(left: 16,right: 16),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: alldata["data"][index]['receiver_id']!=id?Colors.redAccent.withOpacity(0.1):Colors.redAccent,
                        borderRadius: alldata["data"][index]['receiver_id']!=id?BorderRadius.only(bottomLeft:Radius.circular(20), topLeft:Radius.circular(20)):BorderRadius.only(topRight:Radius.circular(20),bottomRight:Radius.circular(20)  )
                      ),
                      child: Text(alldata["data"][index]['message'],
                        textScaleFactor:ScaleSize.textScaleFactor(context),
                        style: TextStyle(color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w900
                        ),
                      ),

                      ),
                          Container(
                            margin: EdgeInsets.only(left: 30,right: 30),
                            child: Text('${DateFormat('hh:mm a').format(DateTime.parse(alldata["data"][index]['created_at']))}',
                              textScaleFactor:ScaleSize.textScaleFactor(context),
                              style: TextStyle(color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w900
                              ),
                            ),
                          ),
                        ],
                      );

                    } ,
                    );
                  }else{
                    return Center(child: CircularProgressIndicator());
                  }

                },
              ),)),
              Container(
                margin: EdgeInsets.only(bottom: context.mediaQueryPadding.bottom),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                width: width,
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GetBuilder<ChatRoomController>(
                        init: ChatRoomController(context: context),
                        builder: (controller) {
                          return Expanded(
                            child: Container(
                              child: TextTypeChat(tec:controller.chatC ),
                            ),
                          );
                        }
                    ),
                    SizedBox(width: 10),
                    Material(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.red[900],
                      child: InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: (){
                          controller.SendMessage(id);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

        );
      }
    );
  }
}
