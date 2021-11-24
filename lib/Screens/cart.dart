import 'package:delivery_app/components/SearchBox.dart';
import 'package:delivery_app/constants.dart';
import 'package:delivery_app/restaurantModel.dart';
import 'package:delivery_app/userModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tab_indicator_styler/flutter_tab_indicator_styler.dart';
import 'package:delivery_app/Screens/dish.dart';
import 'package:delivery_app/Screens/wishList.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class cart extends StatefulWidget {
  const cart({Key? key}) : super(key: key);

  @override
  _cartState createState() => _cartState();
}

class _cartState extends State<cart> {
  @override
  Widget build(BuildContext context) {
    List e=userCart;
    return Container(
      child:  (e.length==0)
          ?Container(child: Center(child: Text("Cart  is empty",),),)
          :ListView.builder(
        // e = biryani items list.
        itemBuilder: (context, index) {
          //This is the container of the food item-->
          return Padding(
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
                      e[index]['image'],
                      height: 110,
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            e[index]['itemName'],
                            style: GoogleFonts.lato(
                              fontSize: 17,
                              color: kTextColor,
                            )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '₹' + e[index]['cost'],
                          style: TextStyle(
                            fontSize: 16,
                            color: kTextLightColor,
                          ),
                        ),
                      ),
                      Text(
                        e[index]['description'],
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
                          color: (e[index]['type'] == 'veg')
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
                            color: (e[index]['type'] == 'veg')
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
          );
        },
        itemCount: e.length,
      ),
    );
  }
}
