import 'package:flutter/material.dart';
import 'package:zechat/helper/constant/scalesize.dart';

class myfrindesContainer extends StatelessWidget {
  final VoidCallback press;
  const myfrindesContainer({super.key,required this.press});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        margin: EdgeInsets.all(16),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.person,)),
                SizedBox(width: 10,),
                Text('Michael',style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                    textScaleFactor:ScaleSize.textScaleFactor(context)
                ),
              ],
            ),
            CircleAvatar(
              child: Text('1',style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),textScaleFactor:ScaleSize.textScaleFactor(context)),
            )
          ],
        ) ,
      ),
    );
  }
}
