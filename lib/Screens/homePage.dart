import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/svg.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

//-------------------------------------------------jashwanth-------------------
class _LoginPageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset("assets/icons/menu.svg"),
          onPressed: (){},
        ),
      ),
      body: Center(
        child: Text(
          'home ',
          style: GoogleFonts.lato(
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
