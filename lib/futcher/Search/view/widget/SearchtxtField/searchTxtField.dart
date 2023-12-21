import 'package:flutter/material.dart';

class SearchEdtTxt extends StatelessWidget {
  final onChanged;
  final TextEditingController tec;

  const SearchEdtTxt({super.key, this.onChanged, required this.tec});

  @override
  Widget build(BuildContext context) {
    return TextField(
        onChanged: onChanged,
        controller: tec,
        cursorColor: Colors.red[900],
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(
              color: Colors.white,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(
              color: Colors.white,
              width: 1,
            ),
          ),
          hintText: "Search new friend here..",
          contentPadding: EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 20,
          ),
          suffixIcon: InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () {},
            child: Icon(
              Icons.search,
              color: Colors.red[900],
            ),
          ),
        )
    );

  }
}
