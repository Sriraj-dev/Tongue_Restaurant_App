import 'package:delivery_app/components/Category_Items.dart';
import 'package:delivery_app/components/SearchBox.dart';
import 'package:delivery_app/constants.dart';
import 'package:delivery_app/restaurantModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  //const Body({Key? key}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with TickerProviderStateMixin{
  List<bool> activeItems = [true,false,false,false,false];
  String title = 'Biryani';

 late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(length: categories.length, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SearchBox(
          onChanged: (value) {},
        ),
        SizedBox(height: 100,),
        Container(
          decoration: new BoxDecoration(color: Theme.of(context).primaryColor),
          child: TabBar(
            tabs: categories.map((e) => Tab(text: e,)).toList(),
            controller: _tabController,
          ),
        ),
       Expanded(
           child: TabBarView(
             controller: _tabController,
             children: categories.map((e) => Container(child: Center(child: Text(e),),)).toList(),
           )
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
