import 'dart:convert';
import 'package:delivery_app/Services/securityServices.dart';
import 'package:delivery_app/Services/storageServices.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
class ApiServices{

  final storage = new FlutterSecureStorage();
  final baseUrl = 'https://stark-beach-59658.herokuapp.com/user/';
  Future checkUser(String text)async{
    var res = await http.get(Uri.parse(baseUrl+'check/$text'));
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
      Uri.parse(baseUrl+'register'),
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
  Future login(String username,String password)async{
    print('trying to log in');
    final encryptedPassword = Security().encrypt(password);
    final user = {
      'username': username,
      'password': encryptedPassword
    };
    print('Ready to post into url');
    var res = await http.post(
        Uri.parse(baseUrl+'login'),
      headers: {
          "Content-Type": "application/json"
      },
      body: json.encode(user)
    );
    print('recieved res');
    Map<String,dynamic> response = json.decode(res.body);
    return response;
    // if(response['status'] == 'true'){
    //   return response['token'];
    // }else{
    //   return response['msg'];
    // }

  }
  Future changePassword(String token,String newPwd)async{
    final encryptedNewPwd = Security().encrypt(newPwd);

    final body = {
      'password': encryptedNewPwd
    };
    var res = await http.patch(
        Uri.parse(baseUrl+'update'),
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
  Future deleteAccount(String token)async{
    var res = await http.delete(
      Uri.parse(baseUrl+'delete'),
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

}