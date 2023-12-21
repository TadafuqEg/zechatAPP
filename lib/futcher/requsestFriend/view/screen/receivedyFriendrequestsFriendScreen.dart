import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zechat/futcher/requsestFriend/controller/requstFriendcontroller.dart';
import 'package:zechat/futcher/requsestFriend/view/widget/Btnaccept.dart';
import 'package:zechat/helper/color.dart';
import 'package:zechat/helper/constant/scalesize.dart';

class RecivedRequestFriendScreen extends StatelessWidget {
  const RecivedRequestFriendScreen({super.key});

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
              init: RequstFriendController(),
              builder: (controller){
            return FutureBuilder(future: controller.GetRequstFriend(context), builder: (context,snapshot){
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
                                      child: Text("${snapshot.data['data']![index]['sender_name']![0]}",
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
                                        Text("${snapshot.data['data']![index]['sender_name']}",
                                          textScaleFactor:ScaleSize.textScaleFactor(context),
                                          style: TextStyle(color: Colors.black,
                                              fontSize: 22,
                                              fontWeight: FontWeight.w900
                                          ),
                                        ),
                                        Text("${snapshot.data['data']![index]['sender_email']}",
                                            textScaleFactor:ScaleSize.textScaleFactor(context),
                                          style: TextStyle(color: Colors.black,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w400
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                BtnAccept(press: () {
                                  controller.AceptFrinerRqust(snapshot.data['data']![index]['request_id']);
                                },
                                btntxt:'Accept' ,
                                  btnColor: kgreenColor,
                                ),
                                BtnAccept(press: () {
                                  controller.RejectFrinerRqust(snapshot.data['data']![index]['request_id']);
                                },
                                btntxt:'Reject' ,
                                  btnColor: Colors.redAccent,
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
