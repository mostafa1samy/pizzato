import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pizza/Views/decider.dart';
import 'package:pizza/Views/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homepage.dart';
String userUid,userEmail;
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future getUid()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    userUid=sharedPreferences.getString('uid');
    userEmail=sharedPreferences.getString('email');
    print(userUid);
    print(userEmail);
  }
  @override
  void initState() {
   getUid().whenComplete(() {
     Timer(
         Duration(seconds: 3),()=>Navigator.pushReplacement(context,
         PageTransition(child:userUid==null? Decider():HomePage(), type:PageTransitionType.leftToRight))
     );
   });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 200.0,
              width: 400.0,
              child: Lottie.asset('animation/slice.json'),
            ), RichText(text: TextSpan(
              text: 'Piz',style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold,color: Colors.white),
              children:<TextSpan> [
            TextSpan(
            text: 'z',style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold,color: Colors.red),),
                TextSpan(
                    text: 'ato',style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold,color: Colors.white),)
              ]
            ))


          ],
        ),
      ),
    );
  }
 /**/ void showToast(String msg, BuildContext ctx) {

    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed:  () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert"),
      content: Text(msg),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
    /*Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.grey,
      textColor: Colors.black,
    );*/
  }
}
