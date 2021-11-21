import 'package:delivery_app/components/SearchBox.dart';
import 'package:delivery_app/constants.dart';
import 'package:delivery_app/restaurantModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tab_indicator_styler/flutter_tab_indicator_styler.dart';
import 'package:delivery_app/Screens/dish.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';


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

      backgroundColor: Background_Color,
      appBar: PreferredSize(
        //preferredSize: Size.fromHeight(MediaQuery.of(context).size.width),
        //preferredSize: appbar.preferredSize *3.5,
        preferredSize: Size.fromHeight(200),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/title_image.png',
                  height: 64,
                ),

              ],
            ),
            SearchBox(
              onChanged: (value) {},
            ),
            TabBar(
              isScrollable: true,
              controller: _tabController,
              tabs: categories
                  .map((e) => Tab(
                        text: e,
                      ))
                  .toList(),
              indicatorSize: TabBarIndicatorSize.label,
              indicator: MaterialIndicator(
                color: kPrimaryColor,
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

                  fontSize: 16, fontWeight: FontWeight.bold, color: kTextColor),

              unselectedLabelStyle: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,

        children: categoryItems
            .map((e) => ListView.builder(
                  // e = biryani items list.
                  itemBuilder: (context, index) {
                    //This is the container of the food item-->

                    return GestureDetector(
                      onTap:()
                        {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Dish()),
                          );
                        },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Image.network(e[index]['image'],height: 130,),
                              // Image.asset(
                              //   'assets/images/noodles.png',
                              //   height: 100,
                              // ),
                              Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      e[index]['itemName'],
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: kTextColor,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '₹'+e[index]['cost'],
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: kTextLightColor,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    e[index]['description'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: kTextLightColor.withOpacity(0.5),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: (e[index]['type'] == 'veg')
                                        ? Colors.green
                                        : Colors.red,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: e.length,
                ))
            .toList(),
      ),
        bottomNavigationBar: ConvexAppBar(
          color: kPrimaryColor,
          backgroundColor: Colors.white,
          activeColor:kPrimaryColor ,
          top: -16,
          items: [
            TabItem(icon: Icons.home),
            TabItem(icon: Icons.favorite_border),
            TabItem(icon: Icons.shopping_bag_outlined,),
            TabItem(icon: Icons.person),
          ],
          initialActiveIndex: 2,//optional, default as 0
          onTap: (int i) => print('click index=$i'),
        )
    );
  }
}
//-------------------------------------------------------------
// tileColor: Colors.white,
// // leading:Container(
// //   height: 110,
// //   decoration: BoxDecoration(
// //     color:Colors.blue,
// //     borderRadius: BorderRadius.circular(20),
// //   ),
// //
// // ),
// leading: Container(
// height: 110,
// width: 110,
// decoration: BoxDecoration(
// shape: BoxShape.circle,
// color: (e[index]['type'] == 'veg')?Colors.green:Colors.red,
// ),
// ),
// title: Text(e[index]['itemName']),
// subtitle: Text(e[index]['description']),
// trailing: Text(e[index]['cost']),
//-------------------------------------------------------------


        

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


