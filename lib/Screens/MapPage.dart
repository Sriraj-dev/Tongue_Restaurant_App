import 'dart:async';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:delivery_app/Services/apiservices.dart';
import 'package:delivery_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:lottie/lottie.dart'as lottie;
import 'package:progress_indicators/progress_indicators.dart';
import 'package:url_launcher/url_launcher.dart';

class MapPage extends StatefulWidget {
  //const MapPage({Key? key}) : super(key: key);
  String partnerId;
  String branchId;
  String partnerName;
  String partnerPhone;
  String deliveryLatitude;
  String deliveryLongitude;

  MapPage(this.partnerId,this.partnerName,this.partnerPhone,this.deliveryLatitude,this.deliveryLongitude,this.branchId);

  @override
  _MapPageState createState() => _MapPageState(partnerId,partnerName,partnerPhone,branchId);
}

class _MapPageState extends State<MapPage> {
  String partnerId;
  String partnerName;
  String partnerPhone;
  String branchId;
  _MapPageState(this.partnerId,this.partnerName,this.partnerPhone,this.branchId);

   LocationData? deliveryLocation;
   LocationData? partnerLocation;
  late Location location;
  Set<Marker> reqMarkers = Set<Marker>();
  Set<Polyline> reqPolyline = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;
  late BitmapDescriptor customIcon;
  Completer<GoogleMapController> _controller = Completer();

  String googleApiKey = "AIzaSyAVLlBmgRwMmdfFJF57nW0gSb6Nw-_bTus";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    location = Location();
    deliveryLocation = LocationData.fromMap({
      "latitude": double.parse(widget.deliveryLatitude),
      "longitude": double.parse(widget.deliveryLongitude)
    });
    polylinePoints = PolylinePoints();
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(0.5, 0.5)), 'assets/images/car.png').then((value){
      customIcon = value;
    });
  }

  showLocationPinsOnMap(){
    var deliveryPosition  = LatLng(deliveryLocation!.latitude??0.0, deliveryLocation!.longitude??0.0);
    var partnerPosition = LatLng(partnerLocation!.latitude??0.0, partnerLocation!.longitude??0.0);

    reqMarkers.removeWhere((marker) => marker.mapsId.value == 'deliveryPosition');
    reqMarkers.removeWhere((marker) => marker.mapsId.value == 'partnerPosition');
    reqMarkers.add(
        Marker(
            markerId: MarkerId('deliveryPosition'),
          position: deliveryPosition,
          infoWindow: InfoWindow(
            title: 'Delivery Location'
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
        )
    );
    reqMarkers.add(
      Marker(
          markerId: MarkerId('partnerPosition'),
        position: partnerPosition,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
        //  icon: customIcon,
        infoWindow: InfoWindow(
          title: "Delivery Partner"
        )
      )
    );
    showPolyLineOnMap();
  }
  void showPolyLineOnMap()async{
    print('---------------------------showing polyline on map------------------------------');
    var result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey,
        PointLatLng(partnerLocation!.latitude??0.0, partnerLocation!.longitude??0.0),
        PointLatLng(deliveryLocation!.latitude??0.0,deliveryLocation!.longitude??0.0)
    );

    if(result.points.isNotEmpty){
      print('points are not empty--------------');
      result.points.forEach((e){
        polylineCoordinates.add(LatLng(e.latitude, e.longitude));
      });
    }else{
      print('---------------------points are empty------------------------');
    }
      reqPolyline.add(Polyline(
          polylineId: PolylineId('polyline'),
          points: polylineCoordinates,
          width: 4,
          color: kPrimaryColor
      ));
    print("req poly line are $reqPolyline");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          StreamBuilder(
            stream:  getPartnerDetails(),
            builder: (context,snapshot){
              switch (snapshot.connectionState){
                case ConnectionState.waiting:
                  return loadingScreen();
                default:
                  if(snapshot.hasError){
                    return errorScreen();
                  }else{
                    Map<String,dynamic> partnerDetails = snapshot.data as Map<String,dynamic>;
                    if(partnerDetails['Name'] == ''){
                      return errorScreen();
                    }else{
                      return GoogleMap(
                        initialCameraPosition: CameraPosition(
                            target: LatLng(partnerLocation!.latitude??0.0,partnerLocation!.longitude??0.0),
                            zoom: 13
                        ),
                        onMapCreated: (GoogleMapController controller){
                          _controller.complete(controller);
                          showLocationPinsOnMap();
                        },
                        markers: reqMarkers,
                        mapType: MapType.normal,
                        polylines: reqPolyline,
                      );
                    }
                  }
              }
            },
          ),
          Positioned(
            bottom: 0,
              child: Container(
                width: size.width,
                height: size.height*0.3,
                decoration: BoxDecoration(
                  color: Background_Color,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 15,left: 15),
                  child: Column(
                    children: [
                      Text('Delivery Partner:',
                          style: GoogleFonts.lato(
                            color: kTextColor,
                            fontSize: 18
                          ),
                      ),
                      ListTile(
                        leading: Icon(Icons.person,color: ksecondaryColor,),
                        title: Text(partnerName,
                          style: GoogleFonts.lato(
                            fontSize: 17,
                            color: kPrimaryColor,
                          ),
                        ),
                        subtitle: Text(partnerPhone,
                          style: GoogleFonts.lato(
                            fontSize: 17,
                            color: ksecondaryColor
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.phone,color: kPrimaryColor,),
                          onPressed: (){
                            launch("tel://+91$partnerPhone");
                          },
                        ),
                      )
                    ],
                  ),
                )
              )
          )
        ],
      ),
    );
  }

  Center errorScreen() {
    return Center(
                    child: Text('An Error Occurred!',
                      style: GoogleFonts.lato(
                        fontSize: 18,
                        color: kPrimaryColor,
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
          child: lottie.Lottie.asset('assets/userMapLoading.json'),
        ),
        SizedBox(height: 10,),
        FadingText('Loading ...',
          style: GoogleFonts.lato(
              fontSize: 19,
              color: kTextColor
          ),
        )
      ],
    );
  }

  Stream getPartnerDetails()=>
      Stream.periodic(Duration(seconds: 10)).asyncMap((_) => getPartnerLocation());

  getPartnerLocation()async{
    Map<String, dynamic> data = {'partnerId': partnerId, 'branchId': branchId};

    var response = await ApiServices().getDeliveryPartnerDetails(data);
    if(response['latitude'] != ""){
      partnerLocation = LocationData.fromMap({
        'latitude' : double.parse(response['latitude']),
        'longitude': double.parse(response['longitude'])
      });
    }
    showLocationPinsOnMap();
    return response;
  }
}

//17.498372,78.3887937

//TODO: edit loadingScreen,Edit Error Screen.