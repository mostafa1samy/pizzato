import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pizza/adminpanel/view/deliveryoptions.dart';
import 'package:provider/provider.dart';

class AdminDetailHelper with ChangeNotifier{
  GoogleMapController googleMapController;
  Map<MarkerId,Marker>markers=<MarkerId,Marker>{};
  initMarker(coll,collId){
    var varMarkerId=collId;
    final MarkerId markerId=MarkerId(varMarkerId);
    final Marker marker=Marker(markerId: markerId,
    position: LatLng(coll['location'].latitude,coll['location'].longitude),
      infoWindow: InfoWindow(title: 'Order',snippet: coll['address'])
    );
    markers[markerId]=marker;
  }
  getMrkerData()async{
    FirebaseFirestore.instance.collection('adminCollections').get().then((docData){
      if(docData.docs.isNotEmpty){
        for(int i= 0; i<docData.docs.length;i++){
          initMarker(docData.docs[i].data(),docData.docs[i].id);
          print(docData.docs[i].data());
        }
      }
    });
  }

  showGoogleMap(BuildContext context,DocumentSnapshot documentSnapshot){
    return GoogleMap(
        mapType: MapType.hybrid,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        compassEnabled: true,
        onMapCreated: (GoogleMapController g){
          googleMapController=g;
          notifyListeners();
        },
        initialCameraPosition:CameraPosition(
      zoom: 15,
      target: LatLng(documentSnapshot.data()['location'].latitude,documentSnapshot.data()['location'].longitude)
    ));
  }

  detailSheet(BuildContext context,DocumentSnapshot documentSnapshot){
   getMrkerData();
    return showModalBottomSheet(

        isScrollControlled: true,
        context: context, builder: (context){
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.symmetric(horizontal: 150),child: Divider(thickness: 4,color: Colors.white,),),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(EvaIcons.person,color: Colors.red,),
                          Padding(padding:EdgeInsets.only(left: 8),
                          child: Container(

                              child: Text(documentSnapshot.data()['username'],style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 16))),)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        children: [
                          Icon(FontAwesomeIcons.mapPin,color: Colors.lightBlueAccent,),
                          Container(
                            constraints: BoxConstraints(
                                maxWidth: 366
                            ),
                            child: Padding(padding:EdgeInsets.only(left: 8),
                              child: Text(documentSnapshot.data()['address'],style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 16)),),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 400,
                    width: 400,
                    child: showGoogleMap(context, documentSnapshot),
                  ),
                ),Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:8),
                          child: Row(
                            children: [
                              Icon(FontAwesomeIcons.clock,color: Colors.lightGreenAccent,),
                              Text(documentSnapshot.data()['time'],style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 16))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:8),
                          child: Row(
                            children: [
                              Icon(FontAwesomeIcons.rupeeSign,color: Colors.lightBlueAccent),
                              Text(documentSnapshot.data()['price'].toString(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 16))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:8.0),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage: NetworkImage(documentSnapshot.data()['image']),
                            ),
                            Column(
                              children: [
                                Text('Pizza : ${documentSnapshot.data()['pizza']}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 16)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text('Cheese : ${documentSnapshot.data()['cheese']}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize:12)),
                                    Text('Beacon : ${documentSnapshot.data()['beacon']}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 12)),
                                    Text('Onion : ${documentSnapshot.data()['onion']}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 12)),
                                  ],
                                )
                              ],
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.deepPurple,
                              child: Text(documentSnapshot.data()['size'],
                                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 16)),
                            )
                          ],
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.white)
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 500,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FlatButton.icon(
                          color: Colors.redAccent,
                          onPressed: (){
                            Provider.of<DeliveryOption>(context,listen: false).mangeOrder(context, documentSnapshot, 'cancelled','Delivery Cancelled');
                          }, icon: Icon(FontAwesomeIcons.eye,color: Colors.white,), label:
                        Text('Skip',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 16)),
                        ),
                        FlatButton.icon(
                          color: Colors.lightBlueAccent,
                          onPressed: (){
                            Provider.of<DeliveryOption>(context,listen: false).mangeOrder(context, documentSnapshot, 'deliveredOeders','Delivery Accepted');
                          }, icon: Icon(FontAwesomeIcons.delicious,color: Colors.white,), label:
                        Text('Deliver',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 16)),
                        ),

                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton.icon(
                    color: Colors.orangeAccent,
                    onPressed: (){}, icon: Icon(FontAwesomeIcons.phone,color: Colors.white,), label:
                  Text('Contact the Owner',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 16)),
                  ),
                )
              ],
            ),
            height: MediaQuery.of(context).size.height*.97,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),color: Color(
              0xff200b4b
            )
            ),
          );
    });
  }
}