import 'package:flutter/material.dart';
import 'package:zechat/helper/color.dart';
import 'package:zechat/helper/constant/scalesize.dart';

class BtnHome extends StatelessWidget {
  final VoidCallback press;
  final String btntxt;
  const BtnHome({super.key,required this.press,required this.btntxt});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue.shade900,
      minimumSize: Size(80, 40),
      padding: EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    );
    return Container(
      // margin: EdgeInsets.only(left: 25,right: 25),
      child: ElevatedButton(
        style: raisedButtonStyle,
        onPressed: press,
        child: Text('${btntxt}',textScaleFactor:ScaleSize.textScaleFactor(context)),
      ),
    );
  }
}
