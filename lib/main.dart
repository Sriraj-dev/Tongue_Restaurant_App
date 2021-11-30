import 'package:connectivity/connectivity.dart';
import 'package:delivery_app/Screens/Body.dart';
import 'package:delivery_app/Screens/LoginPage.dart';
import 'package:delivery_app/Screens/NetworkError.dart';
import 'package:delivery_app/Screens/homePage.dart';
import 'package:delivery_app/Screens/maintenance.dart';
import 'package:delivery_app/Screens/pageManager.dart';
import 'package:delivery_app/Screens/updateScreen.dart';
import 'package:delivery_app/Services/apiservices.dart';
import 'package:delivery_app/Services/authentication.dart';
import 'package:delivery_app/Services/locationServices.dart';
import 'package:delivery_app/Services/storageServices.dart';
import 'package:delivery_app/constants.dart';
import 'package:delivery_app/restaurantModel.dart';
import 'package:delivery_app/userModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:progress_indicators/progress_indicators.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  bool isLogin = false;
  final value  = await Storage().getData();
  print('value is - $value');
  if(value[0]!=null){
    isLogin = true;
  }else{
    isLogin = false;
  }
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: kPrimaryColor ,
          scaffoldBackgroundColor: Colors.white ,
          textTheme: TextTheme(
          bodyText1: TextStyle(color: ksecondaryColor ),
            bodyText2: TextStyle(color: ksecondaryColor ),
          ) ,
        ),
        home: LaunchScreen(isLogin,value),
  )
  );
}

class LaunchScreen extends StatefulWidget {
  //const LaunchScreen({Key? key}) : super(key: key);
  bool isLogin;
  List<String?> value;
  LaunchScreen(this.isLogin,this.value);
  @override
  _LaunchScreenState createState() => _LaunchScreenState(isLogin,value);
}

class _LaunchScreenState extends State<LaunchScreen> {
  bool isLogin;
  List<String?> value;
  _LaunchScreenState(this.isLogin,this.value);

  late Future<int> route;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    route = loadApp();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<int>(
        future: route,
        builder: (context,AsyncSnapshot<int> snapshot){
          if(snapshot.hasData){
            switch(snapshot.data){
              case 0:
                return PageManager();
              case 1:
                return LoginPage();
              case 2:
                return UpdateScreen();
              case 3:
                return MaintenanceScreen();
              case 4:
                return NetworkError();
              default:
                return LoginPage();
            }
          }else if(snapshot.hasError){
            return Center(
              child: Text('An Error Occured! ${snapshot.error}'),
            );
          }else{
            //------------------------This is the SplashScreen-------------------->
            return splashScreen(context);
          }
        },
      ),
    );
  }

  Column splashScreen(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 32),
          child: Image.asset('assets/images/title_image.png'),
        ),
        Image.asset('assets/images/splash.png'),
        Expanded(child: Container(
          width:  MediaQuery.of(context).copyWith().size.width,
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Loading ',style:TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ) ,

                  ),
                  JumpingText('...'),

                ],
              ),
            ),
          ),
        )),
      ],
    );
  }
  Future<int> loadApp()async{
    //check the internet availability-->
    final network = await checkNetwork();
    if(network){
      underMaintenance = await ApiServices().checkMaintenance();
      if(!underMaintenance){
        print('App is not under maintenance = $underMaintenance');
        updateAvailable = await ApiServices().checkUpdates();
        if(!updateAvailable){
          // initialise the items of restaurant -->
          print('App does not have any updates = $updateAvailable');
          print('getting items from restaurant');
          items = await ApiServices().getItems();
          print(items.length);
          print('got items from restaurant');
          initialiseCategories();
          initialiseCategoryItems();
          initialiseMenu();
          if(isLogin){
            //if the user is already logged in -->
            print(value[0]);
            print(value[1]);
            var isLogin = await Authentication().login(value[0]??'',value[1]??'', true);
            if(isLogin == 'true'){
              getUserInfo();
              await getUserFav();
              await getUserCart();
              return 0;
            }else{
              showSnackBar('An error Occured!', context);
              return 5;
            }
          }else{
            //if the user need to login-->
            //return LoginPage();
            return 1;
          }
        }else{
          //if the app has updates available-->
          //return UpdateScreen();
          return 2;
        }
      }else{
        //if the app is under maintenance-->
        //return MaintenanceScreen();
        return 3;
      }
    }else{
      return 4;
    }
  }

  void showSnackBar(String isLogin, BuildContext context) { // isLogin == usernmae is incorrect or password is incorect;
    final snackBar  = SnackBar(
      content: Text(isLogin) ,
      backgroundColor: Colors.red,
      padding: EdgeInsets.only(left: 15,right: 15,bottom: 20),
      behavior: SnackBarBehavior.floating,
    );
    //Scaffold.of(context).showSnackBar(snackBar)
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<bool> checkNetwork()async {
    final result = await Connectivity().checkConnectivity();
    if(result == ConnectivityResult.none)
      return false;
    else return true;
  }


}
//TODO : search
//TODO : user login
//TODO : restaurant side website(includes consolidation and assigning of the delivery persons)
//TODO : gps for the driver
//TODO : location of the client
//TODO : call through app
//TODO : wishlist
//TODO : payment gateway
//TODO : offers
//TODO : review and ratings