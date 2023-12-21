import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zechat/futcher/home/controller/Homecontroller.dart';
import 'package:zechat/futcher/home/view/widget/Btnhome.dart';
import 'package:zechat/futcher/home/view/widget/UserContainer/userContainer.dart';
import 'package:zechat/futcher/myfrined/controller/myfriendcontroller.dart';
import 'package:zechat/helper/color.dart';
import 'package:zechat/helper/constant/scalesize.dart';

class HomeViewScreen extends StatelessWidget {
  const HomeViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.put(HomeController(context: context));
    var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return GetBuilder(
      init: HomeController(context: context),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: false,
            title: Text('Chat',textScaleFactor:ScaleSize.textScaleFactor(context)),
            actions: [IconButton(onPressed: (){
              Get.toNamed('/searchScreen');
            } ,icon: Icon(Icons.search),),
            IconButton(onPressed: (){
              Get.toNamed('/unFriendScreen');
            }, icon: Icon(Icons.switch_account)),

            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BtnHome(press: (){

                      Get.toNamed('/myfrindScreen');
                    },btntxt: 'My Friend',),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BtnHome(press: (){
                      Get.toNamed('/sentreqfriend');
                    },btntxt: 'View Sent Requsets',),
                    BtnHome(press: (){
                      Get.toNamed('/receivedreqfriend');
                    },btntxt: 'View Friend Requsets',),
                  ],
                ),
                GetBuilder(
                    init: MyFriendController(),
                    builder: (controller) {
                      return FutureBuilder(
                          future: controller.GetMyFriend(context),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: const CircularProgressIndicator());
                            } else if (snapshot.hasData) {
                              return Container(
                                width:double.infinity,
                                height: height - 100,
                                child: ListView.builder(
                                    itemCount: snapshot.data['data'].length,
                                    itemBuilder: (context,index){
                                      return Container(
                                          width:double.infinity,
                                          margin: EdgeInsets.all(16),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 30,
                                                    child: Text("${snapshot.data['data']![index]['name']![0]}",
                                                      textScaleFactor:ScaleSize.textScaleFactor(context),
                                                      style: TextStyle(color: Colors.black,
                                                          fontSize: 22,
                                                          fontWeight: FontWeight.w900
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 5,),
                                                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text("${snapshot.data['data']![index]['name']}",
                                                        style: TextStyle(color: Colors.black,
                                                            fontSize: 22,
                                                            fontWeight: FontWeight.w900
                                                        ),

                                                        textScaleFactor:ScaleSize.textScaleFactor(context),
                                                      ),
                                                      Text("${snapshot.data['data']![index]['email']}",
                                                          textScaleFactor:ScaleSize.textScaleFactor(context)
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              InkWell(
                                                onTap: (){
                                                  Get.toNamed("/chat-room",
                                                      arguments:
                                                    {
                                                      "id": snapshot.data['data']![index]['id'],
                                                      "name":snapshot.data['data']![index]['name'],
                                                      "email":snapshot.data['data']![index]['email'],
                                                      "FcmToken":snapshot.data['data']![index]['FcmToken'],
                                                    }

                                                  );
                                                },
                                                child: CircleAvatar(
                                                  radius: 25,
                                                  backgroundColor: kPrimaryColor,
                                                  child: Icon(Icons.chat,color: Colors.white,),
                                                ),
                                              )
                                            ],
                                          )
                                      );
                                    }),
                              );
                            }else{
                              return Text("No Friend");
                            }
                          });
                    }),

                // myfrindesContainer(
                //   press: (){
                //     Get.toNamed("/chat-room");
                //   },
                // )
              ],
            ),
          ),

        );
      }
    );
  }
}
