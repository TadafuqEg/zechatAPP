import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zechat/futcher/myfrined/controller/myfriendcontroller.dart';
import 'package:zechat/helper/color.dart';
import 'package:zechat/helper/constant/scalesize.dart';

class MyFriendScreen extends StatelessWidget {
  const MyFriendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Friends',
            textScaleFactor: ScaleSize.textScaleFactor(context)),
        leading: IconButton(
          onPressed: () {
            Get.offNamed('/homeview');
          },
          icon: Icon(Icons.chat),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.offNamed('/unFriendScreen');
              },
              icon: Icon(Icons.switch_account))
        ],
      ),
      body: Column(
        children: [
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
        ],
      ),
    );
  }
}
