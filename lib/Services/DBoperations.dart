

import 'package:delivery_app/Services/localStorage.dart';

class DbOperations{

  save(bool isCart, var id){
    String tableName = isCart? 'user_cartItems' : 'user_favItems';
    Map<String,dynamic> data = {
      'iid' : id
    };
    LocalDB.instance.insert(tableName, data);
  }
  getData(bool isCart)async{
    String tableName = isCart? 'user_cartItems' : 'user_favItems';
    List data = await LocalDB.instance.getData(tableName);

    return data;
  }
  delete(bool isCart,var id)async{
    String tableName = isCart? 'user_cartItems' : 'user_favItems';

    LocalDB.instance.delete(tableName, id);
  }
}