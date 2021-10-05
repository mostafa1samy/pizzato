import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart'as geoCo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
String finalAddress='Search Address.....';
class GenerateMaps extends ChangeNotifier{
  String finalAddress='Search Address.....';
  String get getFinalAdress=>finalAddress;
  Position position;
  Position get getposition=>position;
  GoogleMapController googleMapController;
  GeoPoint geoPoint;
  GeoPoint get getGeoPoint=>geoPoint;
  Map<MarkerId,Marker>markers=<MarkerId,Marker>{};
  String countryName,mainAddress='Mock Address';
  String get getCountryName=>countryName;
  String get getMiainAddress=>mainAddress;
  Future getCurrentLocation()async{
    var postionData= await GeolocatorPlatform.instance.getCurrentPosition();
    final cards = geoCo.Coordinates(postionData.latitude,postionData.longitude);
    var address=await geoCo.Geocoder.local.findAddressesFromCoordinates(cards);
    String minAdress= address.first.addressLine;
    print(minAdress);
    finalAddress=minAdress;
    notifyListeners();
  }
  getMarkers(double lat,double lng){
    MarkerId markerId=MarkerId(lat.toString()+lng.toString());
    Marker marker=Marker(markerId: markerId
    , icon: BitmapDescriptor.defaultMarker,
      position: LatLng(lat,lng
      ),
      infoWindow: InfoWindow(title: getMiainAddress ,snippet: 'Country name')

    );
    markers[markerId]=marker;

  }
 Widget fetchMaps(){

      return GoogleMap(
        mapType: MapType.hybrid,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        compassEnabled: true,
        mapToolbarEnabled: true,
        onTap: (loc) async{
          final cords=geoCo.Coordinates(loc.latitude,loc.longitude);
          var address= await geoCo.Geocoder.local.findAddressesFromCoordinates(cords);
          countryName=address.first.countryName;
          mainAddress=address.first.addressLine;
          geoPoint=GeoPoint(loc.latitude,loc.longitude);
          notifyListeners();
         markers==null?getMarkers(loc.latitude,loc.longitude):markers.clear();
          print(loc);
          print(countryName);
          print(mainAddress);

        },
        markers: Set<Marker>.of(markers.values),
          onMapCreated: (GoogleMapController mapcontroller){
            googleMapController=mapcontroller;
            notifyListeners();

          },
          initialCameraPosition: CameraPosition(
            target: LatLng(21.000,21.000),
            zoom: 18
          ));

  }
}