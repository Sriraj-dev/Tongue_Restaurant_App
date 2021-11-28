import 'package:delivery_app/Screens/Signup.dart';
import 'package:delivery_app/Screens/maintenance.dart';
import 'package:delivery_app/components/SearchBox.dart';
import 'package:delivery_app/constants.dart';
import 'package:delivery_app/restaurantModel.dart';
import 'package:delivery_app/userModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tab_indicator_styler/flutter_tab_indicator_styler.dart';

class Dish extends StatefulWidget {
  //const Dish({Key? key}) : super(key: key);
  var item;
  Dish(this.item);

  @override
  _DishState createState() => _DishState(item);
}

class _DishState extends State<Dish> {
  var item;
  _DishState(this.item);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: CustomAppBar(context),
      body: dish_body(),
    );
  }

  Column dish_body() {
    int quantity = 0;
    return Column(
      children: [
        Container(
          height: 270,
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 32.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40),
                          ),
                          color: Background_Color,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Center(
                              child: Text(
                                item['itemName'],
                                style: TextStyle(
                                    fontSize: 32, color: kPrimaryColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Align(
                alignment: Alignment.center,
                child: Material(
                  elevation: 10,
                  shadowColor: Colors.black,
                  color: Background_Color,
                  borderRadius: BorderRadius.all(Radius.circular(250)),
                  child: Container(
                    height: 200,
                    child: Image.network(item['image']),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 32.0, bottom: 24),
            child: Container(
              decoration: BoxDecoration(
                  color: Background_Color,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(40),
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(width: 16),
                        Row(
                          children: [
                            Icon(
                              Icons.timer_outlined,
                              color: kTextLightColor,
                            ),
                            Text('50 min'),
                          ],
                        ),
                        SizedBox(width: 16),
                        Row(
                          children: [
                            Icon(
                              Icons.star_outline_rounded,
                              color: kTextLightColor,
                            ),
                            Text('4.8'),
                          ],
                        ),
                        SizedBox(width: 16),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: (item['type'] == 'veg')
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: (item['type'] == 'veg')
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 4),
                            Text(item['type']),
                          ],
                        ),
                        SizedBox(width: 16),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      '₹' + item['cost'],
                      style: TextStyle(
                        fontSize: 32,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width:16),
                      Expanded(
                        child: Container(
                          child: Column(
                            children: [
                              Text('Dish Description',style:TextStyle(fontSize: 24,color: kTextColor)),
                              Text(item['description'],style:TextStyle(color: kTextLightColor)),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 32,
                          width: 96,
                          decoration: BoxDecoration(
                            color: kPrimaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                child: Text(
                                  '-',
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold,

                                  ),
                                ),
                              ),
                              SizedBox(width: 5),
                              Container(
                                child: Text(
                                  '1',
                                  style: TextStyle(
                                    color:kPrimaryColor,
                                      fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(width: 5),
                              Container(
                                child: Text(
                                  '+',
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold,

                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.all(
                        Radius.circular(32),
                      ),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(32),
                                bottomRight: Radius.circular(32))),
                        child: Text(
                          'ADD TO CART',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  PreferredSize CustomAppBar(BuildContext context) {
    return PreferredSize(
      //preferredSize: Size.fromHeight(MediaQuery.of(context).size.width),
      //preferredSize: appbar.preferredSize *3.5,
      preferredSize: Size.fromHeight(250),
      child: Padding(
        padding: const EdgeInsets.only(top: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: IconButton(
                  iconSize: 25,
                  // onPressed: () {
                  //   Navigator.pop(context);
                  // },
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => signup(),
                      ), // map == name,cost,id,offer.
                    );
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_outlined,
                    color: kTextColor,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: IconButton(
                  iconSize: 25,
                  onPressed: () {
                    setState(() {
                      if (!userFav.contains(item))
                        userFav.add(item);
                      else {
                        userFav.remove(item);
                      }
                    });
                  },
                  icon: (userFav.contains(item))
                      ? Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : Icon(
                          Icons.favorite_border,
                          color: Colors.black,
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
