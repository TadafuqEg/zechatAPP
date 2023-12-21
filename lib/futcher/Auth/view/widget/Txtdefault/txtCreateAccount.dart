import 'package:flutter/material.dart';
import 'package:zechat/helper/color.dart';

class txtLogin extends StatelessWidget {
  const txtLogin({super.key});

  @override
  Widget build(BuildContext context) {
    var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Text('LOGIN IN',
    style: TextStyle(
      color: kPrimaryColor,
      fontFamily: 'Sansation',
      fontSize: width *0.05
    ),
    );
  }
}
