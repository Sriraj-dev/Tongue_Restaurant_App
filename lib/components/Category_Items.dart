import 'package:delivery_app/constants.dart';
import 'package:flutter/material.dart';
class CategoryItem extends StatelessWidget {
  final String title;
  final bool isActive;
  final Function press;
  const CategoryItem(
      {Key? key,
        required this.isActive,
        required this.press,
        required this.title})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Text(title,
              style: isActive
                  ? TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: kTextColor)
                  : TextStyle(fontSize: 16)),
          if (isActive)
            Container(
              width: 22,
              height: 3,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
        ],
      ),
    );
  }
}
