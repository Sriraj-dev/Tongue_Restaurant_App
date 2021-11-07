import 'package:delivery_app/components/Category_Items.dart';
import 'package:delivery_app/components/SearchBox.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  //const Body({Key? key}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<bool> activeItems = [true,false,false,false,false];
  String title = 'Biryani';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SearchBox(
          onChanged: (value) {},
        ),
        categoryList(),
        Center(
          child: Text(title),
        )
      ],
    );
  }

  SingleChildScrollView categoryList() {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CategoryItem(
              title: "biryani",
              isActive: activeItems[0],
              press: () {
                setState(() {
                  activeItems = [true,false,false,false,false];
                  title = 'biryani';
                });
              },
            ),
            CategoryItem(
              title: "chinese",
              isActive: activeItems[1],
              press: () {
                setState(() {
                  activeItems = [false,true,false,false,false];
                  title = 'chinese';
                });
              },
            ),
            CategoryItem(
              title: "starters",
              isActive: activeItems[2],
              press: () {
                setState(() {
                  activeItems = [false,false,true,false,false];
                  title = 'starters';
                });
              },
            ),
            CategoryItem(
              title: "Beaverages",
              isActive: activeItems[3],
              press: () {
                setState(() {
                  activeItems = [false,false,false,true,false];
                  title = 'Beaverages';
                });
              },
            ),
            CategoryItem(
              title: "juices",
              isActive: activeItems[4],
              press: () {
                setState(() {
                  activeItems = [false,false,false,false,true];
                  title = 'juices';
                });
              },
            ),
          ],
        ),
      );
  }
}
