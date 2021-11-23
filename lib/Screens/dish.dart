import 'package:delivery_app/Screens/maintenance.dart';
import 'package:delivery_app/components/SearchBox.dart';
import 'package:delivery_app/constants.dart';
import 'package:delivery_app/restaurantModel.dart';
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
    return Column(
      children: [
        Container(
          height: 250,
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                        color: Background_Color,
                      ),
                    ),
                  )
                ],
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  child: Image.asset(item['image']),
                  // Image.asset(
                  //   'assets/images/6.png',
                  //   height: 200,
                  // ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            color: Background_Color,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Text(
                    item['itemName'],
                    style: TextStyle(fontSize: 32, color: kPrimaryColor),
                  ),
                ),
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
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      '₹' + item['cost'],
                      style: TextStyle(
                        fontSize: 32,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    item['description'],
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: Container(
                    child: Center(
                        child: Text(
                      'Quantity',
                      style: TextStyle(fontSize: 20),
                    )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Container(
                    padding: EdgeInsets.all(0),
                    width: 400,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: kPrimaryColor.withOpacity(0.1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(0),
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red.withOpacity(0),
                          ),
                          child: Icon(
                            Icons.add,
                            size: 100,
                            color: ksecondaryColor,
                          ),
                        ),
                        Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Text(
                                '5',
                                style: TextStyle(
                                  fontSize: 64,
                                  color: kTextColor,
                                ),
                              ),
                            )),
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: kPrimaryColor.withOpacity(0),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Center(
                              child: Text(
                                '−',
                                style: TextStyle(
                                  fontSize: 100,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
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
                  onPressed: () {
                    Navigator.pop(context);
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
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite_border,
                    //TODO : wish list
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
