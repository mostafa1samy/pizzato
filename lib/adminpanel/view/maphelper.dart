import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapHelper with ChangeNotifier{
  GoogleMapController googleMapController;
  Map<MarkerId,Marker>markers=<MarkerId,Marker>{};
  initMarker(specify,specifyId){
    var varMarkerId=specifyId;
    final MarkerId markerId=MarkerId(varMarkerId);
    final Marker marker=Marker(markerId: markerId,
        position: LatLng(specify['location'].latitude,specify['location'].longitude),
        infoWindow: InfoWindow(title: 'Order',snippet: specify['address'])
    );
    markers[markerId]=marker;
  }
  getMrkerData(String collection)async{
    FirebaseFirestore.instance.collection(collection).get().then((docData){
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
        mapType: MapType.satellite,
        myLocationButtonEnabled: true,
        markers: Set<Marker>.of(markers.values),
        myLocationEnabled: true,

        //compassEnabled: true,
        onMapCreated: (GoogleMapController g){
          googleMapController=g;
          notifyListeners();
        },
        initialCameraPosition:CameraPosition(
            zoom: 15,
            target: LatLng(documentSnapshot.data()['location'].latitude,documentSnapshot.data()['location'].longitude)
        ));
  }

}