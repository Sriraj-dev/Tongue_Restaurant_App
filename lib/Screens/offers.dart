import 'package:delivery_app/constants.dart';
import 'package:delivery_app/userModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:progress_indicators/progress_indicators.dart';

class Offers extends StatefulWidget {
  //const Offers({Key? key}) : super(key: key);
  bool allowApply;

  Offers(this.allowApply);

  @override
  _OffersState createState() => _OffersState(allowApply);
}

class _OffersState extends State<Offers> {
  bool allowApply;

  _OffersState(this.allowApply);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Background_Color,
      appBar: AppBar(
        backgroundColor: Background_Color,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Offers',
          style: GoogleFonts.lato(fontSize: 24, color: kPrimaryColor),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
          color: kPrimaryColor,
        ),
      ),
      body: StreamBuilder(
        stream: initialisedOffers.stream,
        builder: (context, snapshot) {
          return (!gotOffers)
              ? loadingScreen()
              : (offers.length == 0)
                  ? noOffersPage()
                  : ListView.builder(
                      itemCount: offers.length,
                      itemBuilder: (context, index) {
                        return offerContainer(offers[index]);
                      },
                    );
        },
      ),
    );
  }

  Column noOffersPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(),
        Lottie.asset('assets/no_offers.json'),
        Text(
          'No Offers!!',
          style: GoogleFonts.lato(color: kTextColor, fontSize: 20),
        ),
      ],
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

  Padding offerContainer(offer) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: Container(
          //height: 200,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        child: Text(
                          offer['code'],
                          style: GoogleFonts.lato(
                              color: Colors.green, fontSize: 17),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  offer['title'],
                  style: GoogleFonts.lato(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  offer['description'],
                  maxLines: 3,
                  style: GoogleFonts.lato(
                    color: ksecondaryColor,
                    fontSize: 17,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                (allowApply) ? applyButton(offer) : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row applyButton(offer) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: (){
            Navigator.of(context).pop(offer['code']);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.green,
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Text(
                  'Apply',
                  style: GoogleFonts.lato(color: Colors.white, fontSize: 17),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
