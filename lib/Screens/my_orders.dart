import 'package:delivery_app/Screens/help_support.dart';
import 'package:delivery_app/Screens/trackingScreen.dart';
import 'package:delivery_app/Services/apiservices.dart';
import 'package:delivery_app/userModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:delivery_app/constants.dart';
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
      body: StreamBuilder(
        stream: initialisedOrders.stream,
        builder: (context, snapshot) {
          print('gotOrders = $gotOrders');
            if(snapshot.hasError){
              return errorScreen();
            }
            else{
              return (gotOrders)?Column(
                children: [
                  SizedBox(height: 20,),
                  Center(child: Lottie.asset('assets/history.json',repeat: false,height: 200,)),
                  SizedBox(height: 40,),
                  Container(
                    height: MediaQuery.of(context).size.height*0.6,
                    child: ListView.builder(
                        itemBuilder:(context,index){
                          return GestureDetector(
                            onTap: (){
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context)=>
                                    TrackingPage(myOrders[index]['orderId']?? myOrders[index]['_id'],myOrders[index]['branchId'])
                                  //help_and_support()
                                  )
                              );
                            },
                            child: ListTile(
                              //onTap: orderTapped(myOrders[index]['orderId']?? myOrders[index]['_id'],myOrders[index]['branchId']),
                              title: Text(myOrders[index]['orderId']?? myOrders[index]['_id']),
                              //subtitle: myOrders[index]['createdAt'],
                              subtitle: Text(myOrders[index]['createdAt']?? ''),
                            ),
                          );
                        },
                      itemCount: myOrders.length,
                    ),
                  )
                ],
              ):loadingScreen();
            }
        }
      ),
    );
  }

   loadingScreen() {
    return Column(
            children: [
              SizedBox(height: 20,),
              Center(child: Lottie.asset('assets/history.json',repeat: true,height: 200,)),
            ],
          );
  }

   errorScreen() {
    return Center(
              child: Text('Unable to fetch your Orders!!'),
            );
  }
}


//TODO: change the ListTile ,edit the loading Screen and error Screen .