import 'package:delivery_app/constants.dart';
import 'package:flutter/material.dart';
class CategoryItem extends StatefulWidget {
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
  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: (){
          widget.press();
        },
        child: Column(
          children: <Widget>[
            Text(widget.title,
                style: widget.isActive
                    ? TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: kTextColor)
                    : TextStyle(fontSize: 16)),
            if (widget.isActive)
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
      ),
    );
  }
}
