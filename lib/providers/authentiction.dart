

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
dynamic erroMessage='';
class Authentiction extends ChangeNotifier{

dynamic get getErrMessage=>erroMessage;
  String uid,userEmail;
  String get getUid=>uid;
  String get getUerEmail=>userEmail;
  final FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  Future loginToAccount(String email,String password)async{
  try{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    UserCredential userCredential=await firebaseAuth.signInWithEmailAndPassword(email: email, password:password);
    User user=userCredential.user;
    uid=user.uid;
    userEmail=user.email;
    sharedPreferences.setString('uid', uid);
    sharedPreferences.setString('email', userEmail);
    print('this out uid=. $uid');
    notifyListeners();
  }
  catch(e){
    switch(e.code){
      case 'user-not-found':
        erroMessage='User Not Found';
        print(erroMessage);
        break;

      case 'wrong-password':
        erroMessage='Wrong Password';
        print(erroMessage);
        break;

      case 'invalid-email':
        erroMessage='sorry invalid Email';
        print(erroMessage);
        break;
    }
  }

  }
  Future createNewAccount(String email,String password)async{
   try{
     SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
     UserCredential userCredential=await firebaseAuth.createUserWithEmailAndPassword(email: email, password:password);
     User user=userCredential.user;
     uid=user.uid;
     userEmail=user.email;
     sharedPreferences.setString('uid', uid);
     sharedPreferences.setString('email', userEmail);
     print('this out uid=. $uid');
     notifyListeners();
   }
   catch(e){
     switch(e.code){
       case 'account-exists-with-different-credential':
         erroMessage='Email already use';
         print(erroMessage);
         break;



       case 'invalid-email':
         erroMessage='sorry invalid Email';
         print(erroMessage);
         break;
     }
   }

  }

}