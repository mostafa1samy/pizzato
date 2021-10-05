import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pizza/Views/decider.dart';
import 'package:pizza/adminpanel/service/adminDetailHelper.dart';
import 'package:pizza/adminpanel/view/loginpage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'deliveryoptions.dart';

class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: (){
          print('Working');
        },
        child: Stack(
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
                        Color(0xFF200B4B),Color(0xFF201F22),Color(0xFF1A1031),Color(0xFF19181F)               ]

                  )
              ),
            ),
            appBar(context),
            dataChips(context),
            dataOrder(context)
          ],
        ),
      ),
      drawer: Drawer(),
      floatingActionButton: floatActioButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
  Widget floatActioButton(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FloatingActionButton(
          backgroundColor: Colors.redAccent,
          onPressed: (){
            Provider.of<DeliveryOption>(context,listen: false).showOrder(context, 'cancelled');
          },child: Icon(
          Icons.cancel,color: Colors.white,
        ),),
        FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          onPressed: (){
            Provider.of<DeliveryOption>(context,listen: false).showOrder(context, 'deliveredOeders');
          },child: Icon(
          FontAwesomeIcons.check,color: Colors.white,
        ),),
      ],
    );
  }
  Widget dataOrder(BuildContext context){
    return Positioned(
        top: 200,
        child: SizedBox(
          height: 800,
          width: 400,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('adminCollections').snapshots(),
            builder: (context,snapshot){
              if(snapshot.connectionState==ConnectionState.waiting){
                return Center(
                  child: CircularProgressIndicator(),
                );

              }
              else{
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.deepPurple),
                    child: Padding(
                      padding: EdgeInsets.all(2.0),
                      child: ListView(

                        children: snapshot.data.docs.map((DocumentSnapshot documentSnapshot){
                          return ListTile(
                            onTap: (){
                              Provider.of<AdminDetailHelper>(context,listen: false).detailSheet(context, documentSnapshot);
                            },
                            trailing: IconButton(icon:Icon(FontAwesomeIcons.magnet,color: Colors.white,), onPressed: (){

                            }),
                            subtitle: Text(documentSnapshot.data()['address'],style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize:14)),
                            title: Text(documentSnapshot.data()['pizza'],style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20),),
                            leading: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 25,
                              backgroundImage: NetworkImage(documentSnapshot.data()['image']),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                );
              }

            },
          ),
        ));
  }
  Widget dataChips(BuildContext context){
    return Positioned(
      top: 110,
      child: Container(
        width: 400,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ActionChip(
                backgroundColor: Colors.purple,
                label: Text('Today',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),), onPressed:(){

            }),
            ActionChip(
                backgroundColor: Colors.purple,
                label: Text('This Week',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),), onPressed:(){

            }),
            ActionChip(
                backgroundColor: Colors.purple,
                label: Text('This Month',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),), onPressed:(){

            })
          ],
        ),
      ),
    );
  }
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
      title: Text('Orders',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24),),
    );
  }
}
