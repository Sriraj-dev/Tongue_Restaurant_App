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
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(horizontal: 25),

      decoration: BoxDecoration(
        color: Colors.white ,
        borderRadius: BorderRadius.circular(50),
      ),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(
            Icons.search,
            color: kTextColor,
          ),
          hintText: "Search ",
          hintStyle: TextStyle(
            color: kTextColor.withOpacity(0.3),
          ),
        ),
      ),
    );
  }
}
