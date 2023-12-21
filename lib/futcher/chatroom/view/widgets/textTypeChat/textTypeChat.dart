import 'package:flutter/material.dart';

class TextTypeChat extends StatelessWidget {
  final TextEditingController tec;
  final focuseNode;
  final onEditingComplete;
  const TextTypeChat({super.key,required this.tec,this.focuseNode,this.onEditingComplete});

  @override
  Widget build(BuildContext context) {
    return TextField(
      autocorrect: false,
      controller: tec,
      focusNode: focuseNode,
        onEditingComplete:onEditingComplete,
      decoration: InputDecoration(
        prefixIcon: IconButton(onPressed: (){},icon: Icon(Icons.emoji_emotions_outlined),),
          border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(100),
      ),
      ),
    );
  }
}
