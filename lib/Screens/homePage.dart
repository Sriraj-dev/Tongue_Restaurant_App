import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:delivery_app/Screens/SearchScreen.dart';
import 'package:delivery_app/Screens/dish.dart';
import 'package:delivery_app/Screens/offers.dart';
import 'package:delivery_app/components/SearchBox.dart';
import 'package:delivery_app/constants.dart';
import 'package:delivery_app/restaurantModel.dart';
import 'package:delivery_app/userModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tab_indicator_styler/flutter_tab_indicator_styler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:lottie/lottie.dart';

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
  String displayAddress = userAddress.split(',')[0];

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
      preferredSize: Size.fromHeight(200),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    AwesomeDialog(
                        context: context,
                        dismissOnTouchOutside: false,
                        dismissOnBackKeyPress: false,
                        showCloseIcon: true,
                        dialogType: DialogType.INFO_REVERSED,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        title: 'Choose your Delivery Location!',
                        btnOkText: 'Current location',
                        btnCancelText: 'Home Location',
                        btnOkOnPress: () async {
                          await getUserLocation();
                          if (userAddress != 'Not Set') {
                            AwesomeDialog(
                                context: context,
                                showCloseIcon: false,
                                dismissOnBackKeyPress: false,
                                dismissOnTouchOutside: false,
                                dialogType: DialogType.SUCCES,
                                title: 'Delivery Location:',
                                desc: '$userAddress',
                                btnOkOnPress: () {
                                  setState(() {
                                    displayAddress = userAddress.split(',')[0];
                                  });
                                })
                              ..show();
                          } else {
                            AwesomeDialog(
                              context: context,
                              showCloseIcon: false,
                              dismissOnBackKeyPress: false,
                              dismissOnTouchOutside: false,
                              dialogType: DialogType.ERROR,
                              title: 'Location Permissions are required!',
                              //btnOkIcon: Icons.cancel,
                              btnOkColor: Colors.red,
                              btnOkOnPress: () {},
                            )..show();
                          }
                        },
                        btnCancelOnPress: () {
                          if (homeAddress == '') {
                            AwesomeDialog(
                              context: context,
                              showCloseIcon: false,
                              dismissOnBackKeyPress: false,
                              dismissOnTouchOutside: false,
                              dialogType: DialogType.INFO_REVERSED,
                              title: 'Home Location is not set!',
                              desc:
                                  'Please set your home location in your profile',
                              //btnOkIcon: Icons.cancel,
                              btnOkColor: Colors.red,
                              btnOkOnPress: () {
                                setState(() {
                                  displayAddress = userAddress.split(',')[0];
                                });
                              },
                            )..show();
                          } else {
                            AwesomeDialog(
                                context: context,
                                showCloseIcon: false,
                                dismissOnBackKeyPress: false,
                                dismissOnTouchOutside: false,
                                dialogType: DialogType.SUCCES,
                                title: 'Delivery Location:',
                                desc: '$homeAddress',
                                btnOkOnPress: () {
                                  setState(() {
                                    displayAddress = homeAddress.split(',')[0];
                                  });
                                })
                              ..show();
                          }
                        })
                      ..show();
                  },
                  child: Container(
                    width: 120,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: kPrimaryColor,
                        ),
                        (displayAddress.length <= 12)
                            ? Text(
                                '$displayAddress',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              )
                            : Text(
                                '${displayAddress.substring(0, 10)}..',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                      ],
                    ),
                  ),
                ),
                Image.asset(
                  'assets/images/title_image.png',
                  height: 50,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Offers(false)));
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/offers_icon.png',
                        height: 32,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Text(
                          'OFFERS',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchScreen()));
            },
            child: SearchBox(
              onChanged: (value) {},
            ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      //itemImage
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Hero(
                                          tag: e[index]['id'],
                                          child: (e[index]['isAvailable'] ==
                                                  true)
                                              ? Stack(
                                                children: [
                                                  Container(
                                                    height: 100,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(40),
                                                      image: DecorationImage(
                                                        image: AssetImage('assets/images/shimmerImage.jpg')
                                                      )
                                                    ),
                                                  ),
                                                  Container(
                                                    color: Colors.white,
                                                    child: Image.network(
                                                      e[index]['image'],
                                                      height: 100,
                                                    ),
                                                  ),
                                                ],
                                              )
                                              : Stack(
                                                children: [
                                                  Container(
                                                    height: 100,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(40),
                                                        image: DecorationImage(
                                                            image: AssetImage('assets/images/shimmerImage.jpg')
                                                        )
                                                    ),
                                                  ),
                                                  Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    50)),
                                                      ),
                                                      child: Container(
                                                        foregroundDecoration:
                                                            BoxDecoration(
                                                          color: Colors.grey,
                                                          backgroundBlendMode:
                                                              BlendMode.saturation,
                                                        ),
                                                        child: Image.network(
                                                          e[index]['image'],
                                                          height: 100,
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          itemDetails(e, index),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 0),
                                            child: (e[index]['isAvailable'] ==
                                                    true)
                                                ? (userCart.contains(
                                                        e[index]['id']))
                                                    ? plusMinusButton(e, index)
                                                    : ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary: (userCart
                                                                  .contains(e[
                                                                          index]
                                                                      ['id']))
                                                              ? ksecondaryColor
                                                              : kPrimaryColor,
                                                          // padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                                                          shape:
                                                              const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10)),
                                                          ),
                                                        ),
                                                        onPressed: () {
                                                          setState(() {
                                                            if (!userCart
                                                                .contains(e[
                                                                        index]
                                                                    ['id'])) {
                                                              addToUserCart(
                                                                  e[index]
                                                                      ['id']);
                                                            } else {
                                                              print(
                                                                  'trying to remove');
                                                              removeFromUserCart(
                                                                  e[index]
                                                                      ['id']);
                                                            }
                                                          });
                                                        },
                                                        child: Center(
                                                            child: Text(
                                                          (userCart.contains(
                                                                  e[index]
                                                                      ['id']))
                                                              ? 'Added'
                                                              : 'Add to Cart',
                                                          style:
                                                              GoogleFonts.lora(
                                                            fontSize: 17,
                                                            color: Colors.white,
                                                          ),
                                                        )),
                                                      )
                                                : Container(
                                                    child: Text(
                                                        'Currectly Unavailable'),
                                                  ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, right: 4),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Container(
                                                width: 16,
                                                height: 16,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: (e[index]['type'] ==
                                                            'veg')
                                                        ? Colors.green
                                                        : Colors.red,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(4)),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: (e[index]
                                                                  ['type'] ==
                                                              'veg')
                                                          ? Colors.green
                                                          : Colors.red,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 70,
                                            ),
                                            LikeButton(
                                              //onTap: onLikeButtonTapped(isLiked,e[index]),
                                              isLiked: userFav
                                                  .contains(e[index]['id']),
                                              likeBuilder: (isLiked) {
                                                final color = isLiked
                                                    ? Colors.red
                                                    : Colors.grey;
                                                return Icon(
                                                  Icons.favorite,
                                                  color: color,
                                                  size: 30,
                                                );
                                              },
                                              onTap: (isLiked) async {
                                                setState(() {
                                                  // if (!userFav.contains(e[index]))
                                                  //   userFav.add(e[index]);
                                                  // else {
                                                  //   userFav.remove(e[index]);
                                                  // }
                                                  if (!userFav.contains(
                                                      e[index]['id'])) {
                                                    addToUserFav(
                                                        e[index]['id']);
                                                  } else {
                                                    removeFromUserFav(
                                                        e[index]['id']);
                                                  }
                                                });
                                                return !isLiked;
                                              },
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [],
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

  Row plusMinusButton(e, int index) {
    int quantity = billingItems
        .firstWhere((element) => element['id'] == e[index]['id'], orElse: () {
      return {'id': 0, 'count': 0};
    })['count'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              changeCount(e[index]['id'], false);
            });
          },
          child: Container(
            decoration: BoxDecoration(
                color: kPrimaryColor, borderRadius: BorderRadius.circular(4)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
              child: Text(
                '-',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        Container(
          child: Text(
            quantity.toString(),
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            setState(() {
              changeCount(e[index]['id'], true);
            });
          },
          child: Container(
            decoration: BoxDecoration(
                color: kPrimaryColor, borderRadius: BorderRadius.circular(4)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
              child: Text(
                '+',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Padding itemDetails(e, int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 10),
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
        ],
      ),
    );
  }
}
//TODO :changeButton(Checkout),NetworkPage, MaintainencePage , checkOutBox , Cart, WishList,UserProfile
//TODO : OffersMongodb
