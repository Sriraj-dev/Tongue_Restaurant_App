import 'package:delivery_app/constants.dart';
import 'package:flutter/material.dart';
class itemCard extends StatefulWidget {
  final String name;
  final String price;
  final String Img_Address;
  const itemCard(
      {Key? key,
        required this.Img_Address,
        required this.name,
        required this.price
       }) : super(key: key);

  @override
  _itemCardState createState() => _itemCardState();
}

class _itemCardState extends State<itemCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16) ,
      child: Stack(
        children:<Widget>[
          Container(
            height: 200,
            width: 140,
            decoration: BoxDecoration(
              color :Colors.white,
              borderRadius:BorderRadius.circular(19),
            ),
            margin: EdgeInsets.fromLTRB(0, 50, 0, 0) ,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 60,
                ),
                Text(
                  "price" ,textAlign: TextAlign.center ,
                ),
              ],
            ) ,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0,0,0) ,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.red ,
            ),
          ),
        ],
      ),
    );
  }
}
