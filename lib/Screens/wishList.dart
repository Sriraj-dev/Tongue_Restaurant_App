import 'package:delivery_app/components/SearchBox.dart';
import 'package:delivery_app/constants.dart';
import 'package:delivery_app/restaurantModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      body: Center(
        child: Text('This is favourites page.',style: GoogleFonts.lato(fontSize: 17),),
      ),
    );
  }
}
