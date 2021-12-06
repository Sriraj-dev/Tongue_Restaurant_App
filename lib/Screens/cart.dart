import 'package:delivery_app/Screens/checkoutpage.dart';
import 'package:delivery_app/Services/BillingServices.dart';
import 'package:delivery_app/constants.dart';
import 'package:delivery_app/restaurantModel.dart';
import 'package:delivery_app/userModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

class cart extends StatefulWidget {
  const cart({Key? key}) : super(key: key);

  @override
  _cartState createState() => _cartState();
}

class _cartState extends State<cart> {
  num totalCost = 0;
  @override
  Widget build(BuildContext context) {
    List e = userCart;
    return Scaffold(
      backgroundColor: Background_Color,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: Center(
          child: Text(
            'Cart',
            style: TextStyle(fontSize: 24, color: kPrimaryColor),
          ),
        ),
      ),
      body: example(e),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(30),

          child: GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => checkout(totalCost),
                ),// map == name,cost,id,offer.
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 85, vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: kPrimaryColor,
              ),
              child: Text(
                'COMPLETE ORDER ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

//example(e)
  Container example(List<dynamic> e) {
    return Container(
      child: (e.length == 0)
          ? Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 64,
                  ),

                  Lottie.asset('assets/shopping.json'),
                  Center(
                    child: Text(
                      "Cart  is empty",
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              // e = UserCart.
              itemBuilder: (context, index) {
                //This is the container of the food item-->
                var req = menu.firstWhere((map) {
                  return map['id'] == e[index];
                });
                int quantity = billingItems.firstWhere((req) => req['id']==e[index] , orElse: (){return {'id': 0,'count':0};})['count'];
                totalCost = Billing().calculateBill(billingItems);
                print('Total cost is - $totalCost');
                var item = req['item'];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
                  child: Material(
                    elevation: 10,
                    color: kPrimaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              item['image'],
                              height: 80,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                padding: const EdgeInsets.all(0.0),
                                child: Row(
                                  children: [
                                    Text(
                                      '₹' + item['cost'],
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: kTextLightColor,
                                      ),
                                    ),
                                    SizedBox(width: 64),
                                    Container(
                                      height: 32,
                                      width: 96,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                        color: kPrimaryColor,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap:(){
                                              setState(() {
                                                changeCount(item['id'], false);
                                              });
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 0.0),
                                              child: Container(

                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text('-',style: TextStyle(fontSize: 24),),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Container(
                                              //TODO quantity
                                              child: Text(quantity.toString()),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap:(){
                                              setState(() {
                                                changeCount(item['id'], true);
                                              });
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 0.0),
                                              child: Container(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text('+'),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16, top: 8),
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
                );
              },
              itemCount: e.length,
            ),
    );
  }
}
