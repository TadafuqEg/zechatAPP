

import 'package:get/get.dart';
import 'package:zechat/futcher/Auth/view/screen/Login/Login.dart';
import 'package:zechat/futcher/Auth/view/screen/register/register.dart';
import 'package:zechat/futcher/Search/view/screen/serach.dart';
import 'package:zechat/futcher/call/view/Screen/index.dart';
import 'package:zechat/futcher/callvoice/view/Screen/callvoice.dart';
import 'package:zechat/futcher/chatroom/view/screen/chatroomview.dart';
import 'package:zechat/futcher/home/view/screen/homeview.dart';
import 'package:zechat/futcher/myfrined/view/screen/MyFriendScreen.dart';
import 'package:zechat/futcher/requsestFriend/view/screen/receivedyFriendrequestsFriendScreen.dart';
import 'package:zechat/futcher/sentrequsetFriend/view/screen/sentreceivedyFriendrequestsFriendScreen.dart';
import 'package:zechat/futcher/unfriendList/view/screen/unfriendList.dart';


part 'app_routes.dart';
class AppPages{
  static final routes=[
    GetPage(name: _Paths.LOGIN, page: ()=>LoginScreen()),
    GetPage(name: _Paths.CREATACCOUNT, page: ()=>CreateAcoountScreen()),
    GetPage(name: _Paths.HOMEVIEW, page: ()=>HomeViewScreen()),
    GetPage(name: _Paths.CHAT_ROOM, page: ()=>ChatRoomView()),
    GetPage(
      name: _Paths.INDEX_PAGE,
      page:() => IndexPage(),
    ),
    GetPage(name: _Paths.UNFRIENDSCREEN, page: ()=>UnFriendScreen()),
    GetPage(name: _Paths.SEARCHSCREEN, page: ()=>SearchScreen()),
    GetPage(name: _Paths.RECEIVEDREQUSTSCREEN, page: ()=>RecivedRequestFriendScreen()),
    GetPage(name: _Paths.SENTREQUSTSCREEN, page: ()=>SentRecivedRequestFriendScreen()),
    GetPage(name: _Paths.MYFRIENDSCREEN, page: ()=>MyFriendScreen()),
    GetPage(name: _Paths.VOICECALL_PAGE, page: ()=>VoiceCallScreen()),
  ];
}
