import 'package:encrypt/encrypt.dart';

class Security{
  final key = Key.fromLength(32);
  final iv = IV.fromLength(16);

   encrypt(String pwd){
     final encrypter = Encrypter(AES(key));
     if(pwd==''||pwd==null){
       final sample = encrypter.encrypt('pwd',iv: iv);
       return sample.base64;
     }
    final encryptedText = encrypter.encrypt(pwd,iv: iv);

    return encryptedText.base64;
  }

  decrypt(dynamic encryptedText){
    final encrypter = Encrypter(AES(key));

    final decryptedText = encrypter.decrypt(encryptedText,iv: iv);
    return decryptedText;
  }
}