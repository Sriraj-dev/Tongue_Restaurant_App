import 'package:flutter/material.dart';
import 'package:delivery_app/constants.dart';

class SearchBox extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const SearchBox({
    Key? key,
    required this.onChanged,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.symmetric(horizontal: 25,vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white ,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 2,
              spreadRadius: 0.5
            )
          ]
        ),
        child: TextField(
          onChanged: onChanged,
          decoration: InputDecoration(
            border: InputBorder.none,
            // icon: Icon(
            //   Icons.search,
            //   color: kTextColor,
            // ),
            hintText: "Search ",
            hintStyle: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: kTextColor.withOpacity(0.3),
            ),
          ),
        ),
      ),
    );
  }
}
