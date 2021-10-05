import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:pizza/Views/splashscreen.dart';
import 'package:pizza/providers/authentiction.dart';
import 'package:provider/provider.dart';

class MangeData extends ChangeNotifier{
  FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
  Future fetchData(String collection)async{
    QuerySnapshot querySnapshot= await firebaseFirestore.collection(collection).get();
    return querySnapshot.docs;
  }
  Future submitData(BuildContext context,dynamic data)async{
    return FirebaseFirestore.instance.collection('myOrders').doc(Provider.of<Authentiction>(context,listen: false).getUid).set(data);
  }
  Future delet(BuildContext context){
    return FirebaseFirestore.instance.collection('myOrders').doc(
        Provider.of<Authentiction>(context,listen: false).getUid==null?userUid:Provider.of<Authentiction>(context,listen: false).getUid
    ).delete();
  }
}