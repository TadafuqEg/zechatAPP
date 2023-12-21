import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zechat/futcher/requsestFriend/controller/requstFriendcontroller.dart';
import 'package:zechat/futcher/requsestFriend/view/widget/Btnaccept.dart';
import 'package:zechat/futcher/sentrequsetFriend/controller/sentrequstFriendcontroller.dart';
import 'package:zechat/helper/constant/scalesize.dart';

class SentRecivedRequestFriendScreen extends StatelessWidget {
  const SentRecivedRequestFriendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Friends Requests',textScaleFactor:ScaleSize.textScaleFactor(context)),
        leading:  IconButton(onPressed: (){
          Get.offNamed('/homeview');
        } ,icon: Icon(Icons.chat),),
        actions: [
          IconButton(onPressed: (){
            Get.offNamed('/unFriendScreen');
          }, icon: Icon(Icons.switch_account))
         ],
      ),
      body: Column(
        children: [
          GetBuilder(
              init: SentRequstFriendController(),
              builder: (controller){
            return FutureBuilder(future: controller.GetSentRequstFriend(context), builder: (context,snapshot){
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: const CircularProgressIndicator());
              }else if(snapshot.hasData){
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
                                      child: Text("${snapshot.data['data']![index]['receiver_name']![0]}",
                                        textScaleFactor:ScaleSize.textScaleFactor(context),
                                      ),
                                    ),
                                    SizedBox(width: 5,),
                                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${snapshot.data['data']![index]['receiver_name']}",
                                          textScaleFactor:ScaleSize.textScaleFactor(context),
                                        ),
                                        Text("${snapshot.data['data']![index]['receiver_email']}",
                                            textScaleFactor:ScaleSize.textScaleFactor(context)
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            )
                        );
                      }),
                );
              }else{
                return Text('No Data');
              }
            });

          }),
        ],
      ),

    );
  }
}
