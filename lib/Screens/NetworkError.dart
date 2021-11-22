import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NetworkError extends StatefulWidget {
  const NetworkError({Key? key}) : super(key: key);

  @override
  _NetworkErrorState createState() => _NetworkErrorState();
}

class _NetworkErrorState extends State<NetworkError> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'No Internet',
          style: GoogleFonts.lato(
            fontSize: 17
          ),
        ),
      ),
    );
  }
}
