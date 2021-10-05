import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pizza/Serivces/map.dart';
import 'package:pizza/Views/decider.dart';
import 'package:pizza/Views/login.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Header extends ChangeNotifier{
  Widget appBar(BuildContext context){
    return AppBar(
      backgroundColor: Colors.transparent,
      actions: [
        IconButton(icon: Icon(EvaIcons.logOutOutline,size: 16,), onPressed:()async{
          SharedPreferences s= await SharedPreferences.getInstance();
          s.remove('uid');
          Navigator.pushReplacement(context, PageTransition(child:  Decider(), type: PageTransitionType.leftToRight));

        }),
      ],
      centerTitle: true,
      title: Text('Home',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24),),
    );
  }
 Widget headerText(){
    return Container(
      constraints: BoxConstraints(maxWidth: 250.0),
      child: RichText(text: TextSpan(
          text: 'What would you like',style: TextStyle(fontSize: 29,fontWeight: FontWeight.w300,color: Colors.white),
          children:<TextSpan> [
            TextSpan(
              text: 'to eat ?',style: TextStyle(fontSize: 46,fontWeight: FontWeight.w600,color: Colors.greenAccent),),

          ]
      )),
    );
 }
 Widget headerMenu(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(top:20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: (){},
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(color: Colors.redAccent,blurRadius: 15.0)
                ],
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: Colors.grey.shade100
              ),
              width: 100,
              height: 40,
              child: Center(
                child: Text("All Food",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){},
            child: Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(color: Colors.lightBlueAccent,blurRadius: 15.0)
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: Colors.grey.shade100
              ),
              width: 100,
              height: 40,
              child: Center(
                child: Text("Pasta",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){},
            child: Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(color: Colors.lightBlueAccent,blurRadius: 4)
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: Colors.grey.shade100
              ),
              width: 100,
              height: 40,
              child: Center(
                child: Text("Pizza",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
              ),
            ),
          )
        ],
      ),
    );
 }

}