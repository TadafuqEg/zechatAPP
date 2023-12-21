import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zechat/futcher/Search/controller/searchcontroller.dart';
import 'package:zechat/futcher/home/view/widget/UserContainer/userContainer.dart';
import 'package:zechat/futcher/unfriendList/controller/unfriendController.dart';
import 'package:zechat/futcher/unfriendList/model/unfriendModel.dart';
import 'package:zechat/futcher/unfriendList/view/widget/SearchtxtField/searchTxtField.dart';
import 'package:zechat/helper/constant/scalesize.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

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
        title: Text('Search',textScaleFactor:ScaleSize.textScaleFactor(context)),
        actions: [
          // IconButton(onPressed: (){} ,icon: Icon(Icons.search),),
        IconButton(onPressed: (){
          Get.offNamed('/homeview');
        }, icon: Icon(Icons.chat))
          ,IconButton(onPressed: (){
          Get.offNamed('/unFriendScreen');
        }, icon: Icon(Icons.switch_account))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GetBuilder(
                init: SearchedController(),
                builder: (controller) {
                  return SearchEdtTxt(
                    tec:controller.searchTec ,
                    onChanged: (value){
                      controller.searchFriend(value);
                    },
                    serchbtn: (){
                      controller.searchbtn();
                    }
                  );
                }
            ),
            GetBuilder(
              init:SearchedController() ,
              builder: (controller) {
                return Container(
                  height: height -100,
                  width: double.infinity,
                  child: ListView.builder(
                      itemCount: controller.tempSearch.length,
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
                                      child: Text("${controller.tempSearch[index].name![0]}",
                                        textScaleFactor:ScaleSize.textScaleFactor(context),
                                      ),
                                    ),
                                    SizedBox(width: 5,),
                                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${controller.tempSearch[index].name}",
                                          textScaleFactor:ScaleSize.textScaleFactor(context),
                                        ),
                                        Text("${controller.tempSearch[index].email}",
                                            textScaleFactor:ScaleSize.textScaleFactor(context)
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                IconButton(onPressed: (){},icon:Icon(Icons.add_box_rounded,color: Colors.red.shade600,) ,)

                              ],
                            )
                        );
                      }),
                );
              }
            )



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