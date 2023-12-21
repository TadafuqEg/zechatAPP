part of 'app_pages.dart';

abstract class Routes{

Routes._();

static const LOGIN= _Paths.LOGIN;
static const CREATACCOUNT= _Paths.CREATACCOUNT;
static const HOMEVIEW= _Paths.HOMEVIEW;
static const CHAT_ROOM= _Paths.CHAT_ROOM;
static const INDEX_PAGE = _Paths.INDEX_PAGE;
static const UNFRIENDSCREEN = _Paths.UNFRIENDSCREEN;
static const SEARCHSCREEN = _Paths.SEARCHSCREEN;
static const RECEIVEDREQUSTSCREEN = _Paths.RECEIVEDREQUSTSCREEN;
static const SENTREQUSTSCREEN = _Paths.SENTREQUSTSCREEN;
static const MYFRIENDSCREEN = _Paths.MYFRIENDSCREEN;
static const VOICECALL_PAGE = _Paths.VOICECALL_PAGE;


}
abstract class _Paths{

  static const LOGIN = '/login';
  static const CREATACCOUNT = '/createaccount';
  static const HOMEVIEW = '/homeview';
  static const CHAT_ROOM = '/chat-room';
  static const INDEX_PAGE = '/indexPage';
  static const VOICECALL_PAGE = '/voicecallPage';
  static const UNFRIENDSCREEN = '/unFriendScreen';
  static const SEARCHSCREEN = '/searchScreen';
  static const RECEIVEDREQUSTSCREEN = '/receivedreqfriend';
  static const SENTREQUSTSCREEN = '/sentreqfriend';
  static const MYFRIENDSCREEN = '/myfrindScreen';

}