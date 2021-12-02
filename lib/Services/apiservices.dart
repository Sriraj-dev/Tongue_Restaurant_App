import 'dart:convert';
import 'package:delivery_app/Services/securityServices.dart';
import 'package:delivery_app/Services/storageServices.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
class ApiServices{

  final storage = new FlutterSecureStorage();
  final baseUrl = 'https://stark-beach-59658.herokuapp.com/';
  Future checkUser(String text)async{
    var res = await http.get(Uri.parse(baseUrl+'user/check/$text'));
    Map<String ,dynamic> response = json.decode(res.body);
    return response;
  }


  Future registerUser(String username,String email,String password,String phone,bool googleUser)async{
    final encryptedPassword = Security().encrypt(password);
    final newUser = {
      'username': username,
      'phone': phone,
      'email':email,
      'password': encryptedPassword,
      'googleUser':googleUser
    };
    print("Encrypted password is - ${encryptedPassword.toString()}");
    print('Posting into the Url');
    print(username+password);
    var res = await http.post(
      Uri.parse(baseUrl+'user/register'),
      headers: {
        "Content-Type": "application/json"
      },
      body: json.encode(newUser)
    );
    print('got response after posting');
    Map<String,dynamic> response = json.decode(res.body);
    print(response['status']);
    return response;
    // if(response['status'] == 'true'){
    //   return response['token'];
    // }else{
    //   return response['msg'];
    // }
  }


  Future login(String username,String password,bool encrypted)async{
    print('trying to log in');
    final encryptedPassword = (encrypted)?password:Security().encrypt(password);
    final user = {
      'username': username,
      'password': encryptedPassword
    };
    print('Ready to post into url');
    var res = await http.post(
        Uri.parse(baseUrl+'user/login'),
      headers: {
          "Content-Type": "application/json"
      },
      body: json.encode(user)
    );
    print('recieved res');
    Map<String,dynamic> response = json.decode(res.body);
    return response;
  }


  Future changePassword(String token,String newPwd)async{
    final encryptedNewPwd = Security().encrypt(newPwd);

    final body = {
      'password': encryptedNewPwd
    };
    var res = await http.patch(
        Uri.parse(baseUrl+'user/update'),
      headers: {
          "Content_Type":"application/json",
        "Authorization": token
      },
      body: json.encode(body)
    );
    Map<String,dynamic> response = json.decode(res.body);
    print(response['msg']);
    if(response['status']=='true'){
      await storage.delete(key: 'password');
      await storage.write(key: 'password', value: encryptedNewPwd);
      return "Updated Successfully!";
    }else{
      return response['msg'];
    }

  }

  Future getUserInfo(String token)async{
    var res = await http.get(
        Uri.parse(baseUrl+'user/info'),
      headers: {
        "Content_Type":"application/json",
        "Authorization": token
      },
    );
    Map<String,dynamic> response = json.decode(res.body);
    if(response['status'] == 'true'){
      Map<String,dynamic> userInfo =  response['data'];
      return userInfo;
    }else{
      print('Unable to fetch User data');
      Map<String,dynamic> error = {'username' : ''};
      return error;
    }
  }


  Future deleteAccount(String token)async{
    var res = await http.delete(
      Uri.parse(baseUrl+'user/delete'),
      headers: {
        "Content-Type": "application/json",
        "Authorization":token
      }
    );
    Map<String,dynamic> response = json.decode(res.body);
    if(response['status'] == 'true'){
      await Storage().deleteData();
      return true;
    }
    else return false;
  }

  Future getItems()async{
    var res = await http.get(
      Uri.parse(baseUrl+'tongue/items')
    );
    Map<String,dynamic> response = json.decode(res.body);
    return response['itemList'];
  }

  Future checkMaintenance()async{
    var res = await http.get(Uri.parse(baseUrl+'app/underMaintenance'));
    Map<String,dynamic> response = json.decode(res.body);
    return response['underMaintenance'];
  }

  Future checkUpdates()async{
    var res = await http.get(Uri.parse(baseUrl+'app/updateAvailable'));
    Map<String,dynamic> response = json.decode(res.body);
    return response['updateAvailable'];
  }

  Future placeOrder(Map<String,dynamic> orderDetails)async{
    print('Trying to place Order');
    var res = await http.post(
        Uri.parse(baseUrl +'tongue/currentOrders/add'),
      headers: {
        "Content-Type": "application/json"
      },
      body: json.encode(orderDetails)
    );

    var result = json.decode(res.body);
    if(result['status']){
      print('Order Id is - ${result['orderId']}');
      return result['orderId'];
    }else{
      return 'false';
    }
  }
}