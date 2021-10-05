import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizza/Serivces/mangedata.dart';
import 'package:provider/provider.dart';

class Calculation extends ChangeNotifier{
  int cheeseValue=0,beaconValue=0,onionValue=0,catData=0;
  String size;
  bool isSelected=false,
  smallTapped=false,
  meduimTapped=false,
  largeTapped=false,selected=false;
  int get getCheeseValue=>cheeseValue;
  int get getBeaconValue=>beaconValue;
  int get getOnioneValue=>onionValue;
  int get getCartData=>catData;
 bool get getselect=>selected;
 String get gtSize=>size;
 addCheese(){
   cheeseValue++;
   notifyListeners();
 }
  addBeacon(){
    beaconValue++;
    notifyListeners();
  }
  minusBeacon(){
    beaconValue--;
    notifyListeners();
  }
  minusCheese(){
    cheeseValue--;
    notifyListeners();
  }
  minusOnion(){
    onionValue--;
    notifyListeners();
  }
  addOnion(){
    onionValue++;
    notifyListeners();
  }
  selsctSmallSize()
  {
    smallTapped=true;
    size='S';
    notifyListeners();
  }
  selsctlargeSize()
  {
    largeTapped=true;
    size='L';
    notifyListeners();
  }
  selsctMedunSize()
  {
    meduimTapped=true;
    size='M';
    notifyListeners();
  }
  removeAllData(){
   cheeseValue=0;
   onionValue=0;
   beaconValue=0;
   smallTapped=false;
   largeTapped=false;
   meduimTapped=false;
   notifyListeners();
  }
  addToCart(BuildContext context,dynamic data) async{
   if(smallTapped!=false||largeTapped!=false||meduimTapped!=false)
     {
       catData++;
       await Provider.of<MangeData>(context,listen: false).submitData(context, data);
       notifyListeners();
     }
   else{
     return showModalBottomSheet(context: context, builder:(context){
       return Container(
         height: 50,
         color: Colors.black54,
         child: Center(
           child: Text('Select Size !',style: TextStyle(color: Colors.white),),
         ),
       );
     });
   }
  }
}