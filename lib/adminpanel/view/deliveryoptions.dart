import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pizza/Serivces/map.dart';
import 'package:pizza/adminpanel/service/adminDetailHelper.dart';
import 'package:provider/provider.dart';

import 'maphelper.dart';

class DeliveryOption with ChangeNotifier{
  showMessage(BuildContext context,String message){
    return showModalBottomSheet(context: context, builder:(context){
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),color: Color(
            0xff200b4b
        )
        ),
        height: 50,
        width: 400,
        child: Center(child: Text(message,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 16))),
      );
    });
  }
  showOrder(BuildContext context,String collection){
    return showModalBottomSheet(context: context, builder:(context){
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),color: Color(
            0xff200b4b
        )
        ),
        height: MediaQuery.of(context).size.height*.50,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection(collection).snapshots(),
          builder: (context,snapshot){
            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            else{
              return ListView(
                children: snapshot.data.docs.map((DocumentSnapshot documentsnapshot){
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),color: Color(
                        0xff200b4b
                    )
                    ),
                    child: ListTile(
                      trailing: IconButton(icon:Icon(FontAwesomeIcons.mapPin,color: Colors.green,), onPressed: (){
                         showMap(context, documentsnapshot,collection);
                      }),
                      subtitle: Text(documentsnapshot.data()['name'],style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize:14)),
                      title: Text(documentsnapshot.data()['address'],style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20),),
                      leading: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 25,
                        backgroundImage: NetworkImage(documentsnapshot.data()['image']),
                      ),
                    ),
                  );

                }).toList(),
              );
            }
          },
        ),
      );
    });
  }
  showMap(BuildContext context,DocumentSnapshot documentSnapshotd,String collection){
    Provider.of<MapHelper>(context,listen: false).getMrkerData(collection).whenComplete((){
      return showModalBottomSheet(context: context, builder:(context){
        return Container(
          height: MediaQuery.of(context).size.height*.60,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Padding(padding: EdgeInsets.symmetric(horizontal: 150),child: Divider(
                thickness: 4,
                color: Colors.white,
              ),),
              SizedBox(
                height: 400,
                width: 400,
                child: Provider.of<MapHelper>(context,listen: false).showGoogleMap(context,documentSnapshotd ),
              )
            ],
          ),
        );
      });
    });

  }
  Future mangeOrder(BuildContext context,DocumentSnapshot documentSnapshot,String collection,String message)async{
    await FirebaseFirestore.instance.collection(collection).add({
      'image':documentSnapshot.data()['image'],
      'name':documentSnapshot.data()['username'],
      'pizza':documentSnapshot.data()['pizza'],
      'address':documentSnapshot.data()['address'],
      'location':documentSnapshot.data()['location'],

    }).whenComplete(() {
      showMessage(context, message);
    });
  }

}