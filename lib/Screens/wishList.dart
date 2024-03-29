import 'package:delivery_app/components/SearchBox.dart';
import 'package:delivery_app/constants.dart';
import 'package:delivery_app/restaurantModel.dart';
import 'package:delivery_app/userModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/Screens/dish.dart';
import 'package:lottie/lottie.dart';

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
    List e = userFav;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Background_Color,
        title: Text('Favourites',
          style: GoogleFonts.arvo(
            color: ksecondaryColor,
            fontSize: 25
          ),
        ),
        centerTitle: true,
      ),
        backgroundColor: Background_Color,
        body: Padding(
          padding: const EdgeInsets.only(top: 32,left: 10,right: 10),
          child: (e.length == 0)
              ? Container(
                  child: Center(
                    child: Column(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset('assets/36895-healthy-or-junk-food.json'),
                        Text(
                          "Wish list is empty",
                          style: TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                  ),
                )
              : ListView.builder(
                  // e = biryani items list.
                  itemBuilder: (context, index) {
                    //This is the container of the food item-->
                    var req = menu.firstWhere((map) {
                      return map['id'] == e[index];
                    });
                    var item = req['item'];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Dish(item)), // map == name,cost,id,offer.
                          );
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          elevation: 5,
                          shadowColor: kPrimaryColor.withOpacity(0.5),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          child: Container(
                            height: 110,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: (item['isAvailable'] == true)?Container(
                                    child: Image.network(
                                      item['image'],
                                      height: 110,
                                    ),
                                  ):Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: Colors.grey,
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.network(
                                      item['image'],
                                      height: 110,
                                    ),
                                  )
                                ),
                                Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(item['itemName'],
                                          style: GoogleFonts.lato(
                                            fontSize: 17,
                                            color: kTextColor,
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top:6.0),
                                      child: Text(
                                        '₹' + item['cost'],
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: kTextLightColor,
                                        ),
                                      ),
                                    ),
                                    (item['isAvailable']==true)
                                        ? (userCart.contains(item['id']))?
                                        plusMinusButton(item)
                                        :ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: (userCart.contains(item['id']))?ksecondaryColor:kPrimaryColor,
                                        // padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                        ),
                                      ),
                                      onPressed: (){
                                        setState(() {
                                          if(!userCart.contains(item['id'])){
                                            addToUserCart(item['id']);
                                          }else{
                                            print('trying to remove');
                                            removeFromUserCart(item['id']);
                                          }
                                        });
                                      },
                                      child: Center(
                                        child: Text(
                                          (userCart.contains(item['id']))?'Added':'Add to Cart',
                                          style: GoogleFonts.lora(
                                            fontSize: 17,
                                            color: Colors.white,
                                          ),
                                        )


                                      ),
                                    )
                                        :Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(child: Text('Currently Unavailable')),
                                        )
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
                              ],
                            ),
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

  Row plusMinusButton(item) {
    int quantity = billingItems.firstWhere((element) => element['id']==item['id'] , orElse: (){return {'id': 0,'count':0};})['count'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              changeCount(item['id'], false);
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
              changeCount(item['id'], true);
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
}
