import 'package:delivery_app/components/SearchBox.dart';
import 'package:delivery_app/constants.dart';
import 'package:delivery_app/restaurantModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tab_indicator_styler/flutter_tab_indicator_styler.dart';
class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

//-------------------------------------------------jashwanth-------------------
class _LoginPageState extends State<homePage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: categories.length, vsync: this);
  }
  AppBar appbar = AppBar(
    title: Text('Tongue'),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        //preferredSize: Size.fromHeight(MediaQuery.of(context).size.width),
        //preferredSize: appbar.preferredSize *3.5,
        preferredSize: Size.fromHeight(200),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  iconSize: 25,
                  onPressed: () {},
                  icon: Icon(
                    Icons.menu_rounded,
                    color: kTextColor,
                  ),
                ),
                Text(
                  'Tongue',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: kTextColor,
                  ),
                ),
                IconButton(
                  iconSize: 25,
                  onPressed: () {},
                  icon: Icon(
                    Icons.notifications_none_outlined,
                    color: kTextColor,
                  ),
                ),
              ],
            ),
            SearchBox(
              onChanged: (value) {},
            ),
            TabBar(
              isScrollable: true,
              controller: _tabController,
              tabs: categories.map((e) => Tab(text: e,)).toList(),
              indicatorSize: TabBarIndicatorSize.label,
              indicator: MaterialIndicator(
                color: Colors.red,
                height: 4,
                topLeftRadius: 8,
                topRightRadius: 8,
                bottomLeftRadius: 8,
                bottomRightRadius: 8,
                //horizontalPadding: 10,
                tabPosition: TabPosition.bottom,
              ),
              labelColor: kTextColor,
              labelStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: kTextColor),
              unselectedLabelStyle: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: categoryItems.map(
                (e) => ListView.builder( // e = biryani items list.
              itemBuilder: (context,index){
                //This is the container of the food item-->
                return ListTile(
                  leading: Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (e[index]['type'] == 'veg')?Colors.green:Colors.red,
                    ),
                  ),
                  title: Text(e[index]['itemName']),
                  subtitle: Text(e[index]['description']),
                  trailing: Text(e[index]['cost']),
                  //offers - e[index]['offer'];
                );
              },
              itemCount: e.length,
            )
        )
            .toList(),
      ),

    );
  }
}
//sriraj:
//internet checking,
//sharedPrefs(favourites)
//payment last
//fetching User information
// jaswanth:
// ListTile ,
// ItemPage ,
// loginPage,
// SignUp page,
//menupage(last)