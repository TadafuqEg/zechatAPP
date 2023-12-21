import 'package:flutter/material.dart';
import 'package:zechat/helper/color.dart';

class BtnLogin extends StatelessWidget {
  final VoidCallback press;
  const BtnLogin({super.key,required this.press});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: kPrimaryColor,
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
        child: Text('Login'),
      ),
    );
  }
}
