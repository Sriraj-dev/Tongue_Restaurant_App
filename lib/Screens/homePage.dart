import 'package:delivery_app/components/SearchBox.dart';
import 'package:delivery_app/constants.dart';
import 'package:delivery_app/restaurantModel.dart';
import 'package:delivery_app/userModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tab_indicator_styler/flutter_tab_indicator_styler.dart';
import 'package:delivery_app/Screens/dish.dart';
import 'package:delivery_app/Screens/cart.dart';
import 'package:delivery_app/Screens/wishList.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';

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

  bool isAdded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Background_Color,
      appBar: app_bar(),
      body: home_body(),
    );
  }

  PreferredSize app_bar() {
    return PreferredSize(
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
          Padding(
            padding: const EdgeInsets.only(left: 45),
            child: Tab_Bar(),
          ),
        ],
      ),
    );
  }

  TabBar Tab_Bar() {
    return TabBar(
      isScrollable: true,
      controller: _tabController,
      tabs: categories
          .map((e) => Tab(
                text: e,
              ))
          .toList(),
      labelPadding: EdgeInsets.only(right: 23),
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorPadding: EdgeInsets.only(right: 5),
      indicator: MaterialIndicator(
        color: kPrimaryColor,
        height: 4,
        topLeftRadius: 8,
        topRightRadius: 8,
        bottomLeftRadius: 8,
        bottomRightRadius: 8,
        //horizontalPadding: 10,
        tabPosition: TabPosition.bottom,
        //horizontalPadding: 0,
      ),
      labelColor: kTextColor,
      labelStyle: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: kTextColor),
      unselectedLabelStyle: TextStyle(fontSize: 16),
    );
  }

  TabBarView home_body() {
    return TabBarView(
      controller: _tabController,
      children: categoryItems
          .map((e) => ListView.builder(
                // e = biryani items list.
                itemBuilder: (context, index) {
                  //This is the container of the food item-->
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Dish(e[index])), // map == name,cost,id,offer.
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Material(
                        elevation: 5,
                        shadowColor: kPrimaryColor.withOpacity(0.5),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        child: Container(
                          //height: MediaQuery.of(context).size.height*0.15,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      //itemImage
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.network(
                                          e[index]['image'],
                                          height: 100,
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          itemDetails(e, index),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: (userCart.contains(e[index]))?ksecondaryColor:kPrimaryColor,
                                                // padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                                                shape: const RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                                ),
                                              ),
                                              onPressed: (){
                                                setState(() {
                                                  if (!userCart.contains(e[index]))
                                                    userCart.add(e[index]);
                                                  else {
                                                    userCart.remove(e[index]);
                                                  }
                                                });
                                              },
                                              child: Center(
                                                child: Text(
                                                  (userCart.contains(e[index]))?'Added':'Add to Cart',
                                                  style: GoogleFonts.lora(
                                                    fontSize: 17,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10,right: 4),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 10),
                                              child: Container(
                                                width: 16,
                                                height: 16,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: (e[index]['type'] == 'veg')
                                                        ? Colors.green
                                                        : Colors.red,
                                                  ),
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(4)),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(2.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: (e[index]['type'] == 'veg')
                                                          ? Colors.green
                                                          : Colors.red,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 70,),
                                            LikeButton(
                                              //onTap: onLikeButtonTapped(isLiked,e[index]),
                                              isLiked: userFav.contains(e[index]),
                                              likeBuilder: (isLiked){
                                                final color = isLiked? Colors.red:Colors.grey;
                                                return Icon(Icons.favorite,color: color,size: 30,);
                                              },
                                              onTap: (isLiked)async{
                                                setState(() {
                                                  if (!userFav.contains(e[index]))
                                                    userFav.add(e[index]);
                                                  else {
                                                    userFav.remove(e[index]);
                                                  }
                                                });
                                                return !isLiked;
                                              },
                                            )

                                            // Padding(
                                            //   padding: const EdgeInsets.only(top: 13),
                                            //   child: FittedBox(
                                            //     child: ElevatedButton(
                                            //       style: ElevatedButton.styleFrom(
                                            //         primary: (isAdded)?ksecondaryColor:kPrimaryColor,
                                            //         padding: EdgeInsets.symmetric(vertical: 10,horizontal: 18),
                                            //         shape: const RoundedRectangleBorder(
                                            //           borderRadius: BorderRadius.all(Radius.circular(10)),
                                            //         ),
                                            //       ),
                                            //       onPressed: (){
                                            //         setState(() {
                                            //           isAdded = !isAdded;
                                            //         });
                                            //       },
                                            //       child: Center(
                                            //         child: Text(
                                            //           (isAdded)?'Added':'ADD',
                                            //           style: TextStyle(
                                            //             color: Colors.white,
                                            //           ),
                                            //         ),
                                            //       ),
                                            //     ),
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 0,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [

                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: e.length,
              ))
          .toList(),
    );
  }

  Padding itemDetails(e, int index) {
    return Padding(
                                padding: const EdgeInsets.only(top: 15,bottom: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(0),
                                      child: Text(e[index]['itemName'],
                                          style: GoogleFonts.lato(
                                            fontSize: 18,
                                            color: kTextColor,
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        '₹' + e[index]['cost'],
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: kTextLightColor,
                                        ),
                                      ),
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.only(top: 15),
                                    //   child: Text(
                                    //     e[index]['description'],
                                    //     maxLines: 1,
                                    //     overflow: TextOverflow.fade,
                                    //     softWrap: false,
                                    //     style: TextStyle(
                                    //       fontSize: 16,
                                    //       color: kTextLightColor
                                    //           .withOpacity(0.5),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
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
//sharedPrefs(favourites)
//payment last
//fetching User information
// jaswanth:
// ListTile ,
// ItemPage ,
// loginPage,
// SignUp page,

//menupage(last)
