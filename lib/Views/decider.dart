import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pizza/adminpanel/view/loginpage.dart';

import 'login.dart';

class Decider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [
                      .2,.45,.6,.9
                    ],
                    colors: [
                      Color(0xFFFF6600),Color(0xFFFcF82F),Color(0xFFD3cf00),Color(0xFFff6600)               ]

                )
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/adminuser.jpg')
                )
            ),
          ),
          Positioned(
              top: 90,
              left: 10,
              child:Container(
                height: 200,
                width: 420,
                child: RichText(
                  text: TextSpan(
                      text: 'Select',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 46),
                      children: <TextSpan>[
                        TextSpan(
                            text: ' Your',style: TextStyle(color: Colors.white,fontSize: 40,fontWeight: FontWeight.bold)
                        ),
                        TextSpan(
                            text: ' Side',style: TextStyle(color: Colors.white,fontSize: 40,fontWeight: FontWeight.bold)
                        )
                      ]
                  ),
                ),
              )),
          Positioned(
              top: 200,
              child: Container(
                width: 400,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
            MaterialButton(
                  color: Colors.redAccent,
                  child: Text('User',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),

                  onPressed: (){
                Navigator.pushReplacement(context,
                    PageTransition(child: Login(), type:PageTransitionType.rightToLeft));

            }),
            MaterialButton(
                  color: Colors.redAccent,
                  child: Text('Admin',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),

                  onPressed: (){
                    Navigator.pushReplacement(context,
                        PageTransition(child: LoginPage(), type:PageTransitionType.rightToLeft));

                  })
          ],),
              )),
          Positioned(
              top: 720,
              left: 20,
              right: 20,

              child: Container(
                width: 400,
                constraints: BoxConstraints(maxHeight: 200),
                child: Column(
                  children: [
                    Text("By Continuing You Agree Pizzato's Terms",style: TextStyle(color: Colors.white,fontSize: 12,)),
                    Text("Service & Privacy Policy",style: TextStyle(color: Colors.white,fontSize: 12,))
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
