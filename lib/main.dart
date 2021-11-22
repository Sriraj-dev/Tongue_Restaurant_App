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
import 'package:delivery_app/Services/storageServices.dart';
import 'package:delivery_app/constants.dart';
import 'package:delivery_app/restaurantModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final storage = new FlutterSecureStorage();
  bool isLogin = false;
  final value  = await storage.read(key: 'username');
  print('value is - $value');
  if(value!=null){
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
        home: LaunchScreen(isLogin),
  )
  );
}

class LaunchScreen extends StatefulWidget {
  //const LaunchScreen({Key? key}) : super(key: key);
  bool isLogin;
  LaunchScreen(this.isLogin);
  @override
  _LaunchScreenState createState() => _LaunchScreenState(isLogin);
}

class _LaunchScreenState extends State<LaunchScreen> {
  bool isLogin;
  _LaunchScreenState(this.isLogin);

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
              child: Text('An Error Occured!'),
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
                    'Loading   ',style:TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ) ,
                  ),
                  CircularProgressIndicator(
                    color: Colors.white,
                  )
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
          if(isLogin){
            //if the user is already logged in -->
            final userDetails = await Storage().getData();
            await Authentication().login(userDetails[0], userDetails[1]);
            //return homePage();
            return 0;
          }else{
            //if the user need to login-->
            //return LoginPage();
            return 0;
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