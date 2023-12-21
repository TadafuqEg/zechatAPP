import 'package:flutter/material.dart';
import 'package:zechat/helper/color.dart';

class EdtTxt extends StatelessWidget {
  final String labletxt;
  final String hintText;
  final bool obscureText;
  final keyboardType;
  final  prefixIcon;
  final suffixIcon;
  final TextEditingController tec;
  final errorText;
  const EdtTxt({super.key,required this.labletxt,required this.hintText,required this.obscureText,this.keyboardType,this.prefixIcon,this.suffixIcon,this.errorText,required this.tec});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left:25,right: 25,top: 25 ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text('$labletxt',style: TextStyle(
                    fontFamily: 'Sansation',
                ),),
              ),
              Flexible(
                child: Text('$errorText',style: TextStyle(
                    fontFamily: 'Sansation',
                    color: Colors.red.shade400
                ),),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
            color: kSecondaryColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            keyboardType: keyboardType,
            obscureText: obscureText,
            controller: tec,
            decoration:InputDecoration(
              hintText: "${hintText}",
              prefixIcon: prefixIcon,
              //,
              suffixIcon: suffixIcon,
              border: InputBorder.none,
              hintStyle:  TextStyle(
                  fontFamily: 'Sansation'
              )
            ) ,
          ),
          )
        ],
      ),
    );
  }
}
