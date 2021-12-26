import 'package:delivery_app/Screens/trackingScreen.dart';
import 'package:delivery_app/constants.dart';
import 'package:delivery_app/restaurantModel.dart';
import 'package:delivery_app/userModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:progress_indicators/progress_indicators.dart';

class order_history extends StatefulWidget {
  const order_history({Key? key}) : super(key: key);

  @override
  _order_historyState createState() => _order_historyState();
}

class _order_historyState extends State<order_history> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Background_Color,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Background_Color,
        title: Text(
          'MY ORDERS',
          style: TextStyle(
              fontSize: 24, color: kPrimaryColor, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          color: kPrimaryColor,
          icon: Icon(Icons.arrow_back_ios_rounded),
          iconSize: 25,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: StreamBuilder(
          stream: initialisedOrders.stream,
          builder: (context, snapshot) {
            print('gotOrders = $gotOrders');
            if (snapshot.hasError) {
              return errorScreen();
            } else {
              return (gotOrders)
                  ? (myOrders.length !=0)?ListView.builder(
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => TrackingPage(
                                    myOrders[myOrders.length-index-1]['orderId'] ??
                                        myOrders[myOrders.length-index-1]['_id'],
                                    myOrders[myOrders.length-index-1]['branchId'])
                                //help_and_support()
                                ));
                          },
                          child: myOrderContainer(myOrders[myOrders.length-index-1]),
                        );
                      },
                      itemCount: myOrders.length,
                    ):Column(
                mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(),
                        Lottie.asset('assets/search.json'),
                        SizedBox(height: 10,),
                        Text('No Orders Yet!',
                          style: GoogleFonts.lato(
                            fontSize: 17,
                            color: kTextColor
                          ),
                        )
                      ],
                    )
                  : loadingScreen();
            }
          }),
    );
  }

  myOrderContainer(var order) {
    //print('Date time is - ${order}');
    var orderedAt = DateTime.parse(order['createdAt']??'').toUtc().add(Duration(hours: 5,minutes: 30));
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        elevation: 2,
        child: Container(
          width: MediaQuery.of(context).size.width*0.9,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                    text: TextSpan(
                        text: 'Order Items :',
                        style: GoogleFonts.lato(
                            color: kTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                        ),
                        children: [
                          TextSpan(
                              text: generateYourOrder(order['orderItems']),
                              style: GoogleFonts.lato(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18
                              )
                          )
                        ]
                    )
                ),
                SizedBox(height: 8,),
                RichText(
                    text: TextSpan(
                      text: 'Ordered at :',
                      style: GoogleFonts.lato(
                        color: kTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 17
                      ),
                      children: [
                        TextSpan(
                          text: '${orderedAt.day}-${orderedAt.month}-${orderedAt.year} , ${orderedAt.hour}:${orderedAt.minute}',
                          style: GoogleFonts.lato(
                            color: Colors.black,
                              fontWeight: FontWeight.normal,
                            fontSize: 17
                          )
                        )
                      ]
                    )
                ),
                SizedBox(height: 8,),
                RichText(
                    text: TextSpan(
                        text: 'Cost :',
                        style: GoogleFonts.lato(
                            color: kTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 17
                        ),
                        children: [
                          TextSpan(
                              text: '₹ '+order['amountPaid'],
                              style: GoogleFonts.lato(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 17
                              )
                          )
                        ]
                    )
                ),
                SizedBox(height: 8,),
                RichText(
                    text: TextSpan(
                        text: 'Status :',
                        style: GoogleFonts.lato(
                            color: kTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 17
                        ),
                        children: [
                          TextSpan(
                              text: (order['accepted'])?
                              (order['outForDelivery'])?
                              (order['delivered'])?'Order Delivered!':'Out for delivery!'
                                  :'Food is being prepared!'
                                  :'Order is not yet accepted by restaurant',
                              style: GoogleFonts.lato(
                                  color: Colors.green,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 17
                              )
                          )
                        ]
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  loadingScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(),
        Center(
          child: Lottie.asset('assets/userLoading2.json'),
        ),
        SizedBox(
          height: 10,
        ),
        FadingText(
          'Loading ...',
          style: GoogleFonts.lato(fontSize: 19, color: kTextColor),
        )
      ],
    );
  }

  errorScreen() {
    return Center(
      child: Text('Unable to fetch your Orders!!'),
    );
  }

  generateYourOrder(var orderItems) {
    String yourOrder = '';
    orderItems.forEach((map) {
      var req = menu.firstWhere((element) => element['id'] == map['id']);
      yourOrder +=
          map['count'].toString() + ' ' + req['item']['itemName'] + ',';
    });
    yourOrder = yourOrder.substring(0, yourOrder.length - 1);
    yourOrder += '.';
    return yourOrder;
  }
}

//TODO: change the ListTile ,edit the loading Screen and error Screen .
