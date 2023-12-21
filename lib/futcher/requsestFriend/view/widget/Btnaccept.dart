import 'package:flutter/material.dart';
import 'package:zechat/helper/color.dart';

class BtnAccept extends StatelessWidget {
  final VoidCallback press;
  final String btntxt;
  final Color btnColor;
  const BtnAccept({super.key,required this.press,required this.btntxt,required this.btnColor});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: btnColor,
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
        child: Text('${btntxt}'),
      ),
    );
  }
}
