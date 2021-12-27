import 'dart:convert';
import 'dart:io';
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

  Future changePhone(String token,String newPhone)async{
    Map<String,dynamic> data = {
      'phone': newPhone
    };
    var res = await http.patch(
      Uri.parse(baseUrl+'user/updatePhone'),
      headers: {
        "Content-Type":"application/json",
        "Authorization": token
      },
      body: json.encode(data)
    );
    var result = json.decode(res.body);
    return result['status'];
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


  Future getBranches()async{
    var res = await http.get(
        Uri.parse(baseUrl+'tongue/getAllBranches'),
        headers: {
          "Content-Type": "application/json"
        },
    );

    var result = json.decode(res.body);
    return result['branches'];
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
    print(json.encode(orderDetails));
    var result = json.decode(res.body);
    if(result['status']){
      print('Order Id is - ${result['orderId']}');
      return result['orderId'];
    }else{
      return 'false';
    }
  }

  Future addToMyOrders(Map<String,dynamic> data,String token)async{
    var res = await http.patch(
        Uri.parse(baseUrl+ 'user/addToMyOrders'),
      headers: {
        "Content-Type":"application/json",
        "Authorization": token
      },
      body: json.encode(data)
    );
    print(json.encode(data));
    var result = json.decode(res.body);
    print(result);
    if(result['status']){
      print('added to myOrders');
      return true;
    }else{
      print('error in adding to myOrders');
      return false;
    }
  }

  Future getMyOrders(String token)async{
    var res = await http.get(
        Uri.parse(baseUrl+'user/getMyOrders'),
      headers: {
        "Content_Type":"application/json",
        "Authorization": token
      },
    );
    var result = json.decode(res.body);
    return result;
  }

  Future getOrderDetails(Map<String,dynamic> orderData)async{
    print('Order data is -  $orderData');
    var res = await http.post(
        Uri.parse('https://stark-beach-59658.herokuapp.com/tongue/currentOrders/navigate'),
        headers: {
          "Content-Type": "application/json"
        },
        body: json.encode(orderData)
    );
    print(json.encode(orderData));
    print(res.body);
    var result = json.decode(res.body);
    return result;
  }

  Future getDeliveryPartnerDetails(Map<String,dynamic> data)async{
    print('getting Partner Details using - $data');

    var res = await http.post(
      Uri.parse(baseUrl+'tongue/deliveryPartners/profile'),
      headers: {
        "Content-Type": "application/json"
      },
      body: json.encode(data)
    );
    print( "deliveryPartner -  ${res.body}");
    if(res.statusCode ==200){
      print('status code is 200');
      var result = json.decode(res.body);
      print('returning - ${result['partnerDetails']}');
      return result['partnerDetails'][0];
    }
    else{
      print('Error in getting deliveryPartner details');
      return {
        'Name':"",
      };
    }
  }

  Future rateDeliveryPartner(String branchId,String partnerId,var newRating)async{
    Map<String ,dynamic> data = {
      "branchId":branchId,
      "partnerid":partnerId,
      "rating":newRating
    };
    var res = await http.patch(
      Uri.parse(baseUrl+'user/ratePartner'),
      headers: {
        "Content-Type":"application/json"
      },
      body: json.encode(data)
    );

    var result = json.decode(res.body);
    return result['status'];
  }
  
  Future ratingGiven(Map<String,dynamic> data)async{
    var res = await http.patch(
        Uri.parse(baseUrl+'tongue/pastOrders/rateOrder'),
      headers: {
        "Content-Type":"application/json",
      },
      body: json.encode(data)
    );
    var result = json.decode(res.body);
    print('Order Rated - ${result['status']}');
    return result['status'];
  }

  Future getOffers(Map<String,dynamic> data)async{
    var res = await http.post(
      Uri.parse(baseUrl+'tongue/offers'),
      headers: {
        "Content-Type":"application/json",
      },
      body: json.encode(data)
    );
    var result = json.decode(res.body);
    return result['status'];
  }
}