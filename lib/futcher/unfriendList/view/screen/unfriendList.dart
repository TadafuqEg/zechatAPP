import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zechat/futcher/home/view/widget/UserContainer/userContainer.dart';
import 'package:zechat/futcher/unfriendList/controller/unfriendController.dart';
import 'package:zechat/futcher/unfriendList/model/unfriendModel.dart';
import 'package:zechat/futcher/unfriendList/view/widget/SearchtxtField/searchTxtField.dart';
import 'package:zechat/helper/constant/scalesize.dart';

class UnFriendScreen extends StatelessWidget {
  const UnFriendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Text('Add Friends',textScaleFactor:ScaleSize.textScaleFactor(context)),
        actions: [
          IconButton(onPressed: (){
            Get.offNamed('/homeview');
          } ,icon: Icon(Icons.chat),),
          IconButton(onPressed: (){
          Get.toNamed('/searchScreen');
        } ,icon: Icon(Icons.search),),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GetBuilder(
                init: UnFriendController(),
                builder: (controller){
              return FutureBuilder(future: controller.GetUnfriendList(), builder: (context,snapshot){
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: const CircularProgressIndicator());
                }else if(snapshot.hasData){
                  UnfriendModel unfriendModel = UnfriendModel();
                  unfriendModel = UnfriendModel.fromJson(snapshot.data);

                  return Container(
                    width:double.infinity,
                    height: height - 100,
                    child: ListView.builder(
                        itemCount:unfriendModel.data!.length ,
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
                                      child: Text("${unfriendModel.data![index].name![0]}",
                                          textScaleFactor:ScaleSize.textScaleFactor(context),
                                      ),
                                    ),
                                    SizedBox(width: 5,),
                                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${unfriendModel.data![index].name}",
                                            textScaleFactor:ScaleSize.textScaleFactor(context),
                                        ),
                                        Text("${unfriendModel.data![index].email}",
                                            textScaleFactor:ScaleSize.textScaleFactor(context)
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                controller.isSendFriend[index]?
                                IconButton(onPressed: (){}, icon: Icon(Icons.check_box)):
                                IconButton(onPressed: (){
                                  controller.SendFrintRequest(
                                      unfriendModel.data![index].id,index);
                                },icon:Icon(Icons.add_box_rounded,color: Colors.red.shade600,) ,)

                              ],
                            )
                          );
                        }),
                  );
                }else if(snapshot.hasError){
                  return Text('${snapshot.error}');
                }else{
                  return Text('Error');
                }
              });
            }),

          ],
        ),
      ),

    );
  }
}

/*
GetBuilder(
              init: SearchedController(),
                builder: (controller) {
                return SearchEdtTxt(
                  tec:controller.searchTec ,
                  onChanged: (value){
                    controller.searchFriend(value);
                  },
                );
              }
            )
 */