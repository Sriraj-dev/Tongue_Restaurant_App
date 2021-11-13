import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage{
  final storage = new FlutterSecureStorage();

  saveData(String username,String encryptedPwd)async{
    await storage.deleteAll();
    await storage.write(key: 'username', value: username);
    await storage.write(key: 'password', value: encryptedPwd);
  }

  getData()async{
    List<String?> details = [];
    print('details are - $details');
    var value = await storage.read(key: 'username');
    details.add(value);
    value = await storage.read(key: 'password');
    details.add(value);
    print('details are - $details');
    return details;
  }

  deleteData()async{
    await storage.deleteAll();
  }
}