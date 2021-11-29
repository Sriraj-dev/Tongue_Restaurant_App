import 'package:delivery_app/components/SearchBox.dart';
import 'package:delivery_app/constants.dart';
import 'package:delivery_app/restaurantModel.dart';
import 'package:delivery_app/userModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/Screens/dish.dart';

import 'package:flutter_tab_indicator_styler/flutter_tab_indicator_styler.dart';
import 'package:delivery_app/Screens/cart.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:google_fonts/google_fonts.dart';
class wish_list extends StatefulWidget {
  const wish_list({Key? key}) : super(key: key);

  @override
  _wish_listState createState() => _wish_listState();
}

class _wish_listState extends State<wish_list> {
  @override
  Widget build(BuildContext context) {
    List e= userFav;
    return Scaffold(
        backgroundColor: Background_Color,
        body: Padding(
          padding: const EdgeInsets.only(top:32),
          child: (e.length==0)
            ?Container(child: Center(child: Text("Wish list is empty",),),)
          : ListView.builder(
            // e = biryani items list.
            itemBuilder: (context, index) {
              //This is the container of the food item-->
              var req = menu.firstWhere((map) {
                return map['id'] == e[index];
              });
              var item = req['item'];
              return GestureDetector(
                  onTap: (){
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Dish(item)), // map == name,cost,id,offer.
                      );
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 110,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0,0.5),
                              blurRadius: 1,
                              spreadRadius: 0.5,
                            ),]
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              item['image'],
                              height: 110,
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    item['itemName'],
                                    style: GoogleFonts.lato(
                                      fontSize: 17,
                                      color: kTextColor,
                                    )
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '₹' + item['cost'],
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: kTextLightColor,
                                  ),
                                ),
                              ),
                              Text(
                                item['description'],
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                                softWrap: false,
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
                                border: Border.all(
                                  color: (item['type'] == 'veg')
                                      ? Colors.green
                                      : Colors.red,),
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
                        ],

                      ),
                    ),
                  ),
                );
            },
            itemCount: e.length,
          ),
        )
      //   Center(
      // child: Text('This is cart page.',style: GoogleFonts.lato(fontSize: 17),),
      //   ),
    );
  }
}
