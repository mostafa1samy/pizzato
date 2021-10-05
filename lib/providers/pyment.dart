import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizza/Serivces/map.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentHelper extends ChangeNotifier{
  bool showCheckOutButton=false;
  bool get getShowCheckOutButton=>showCheckOutButton;
  TimeOfDay deleveryTime=TimeOfDay.now();
  Future selectTime(BuildContext context)async{
    final selecttime=await showTimePicker(context: context, initialTime:TimeOfDay.now());
    if(selectTime!=null && selecttime!=deleveryTime){
      deleveryTime=selecttime;
      print(deleveryTime.format(context));
      notifyListeners();
    }
  }
  showCheckOutButtonMethod(){
    showCheckOutButton=true;
    notifyListeners();
  }
  selectLoction(BuildContext context){
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context, builder:(context){

      return Container(
        child: Column(
          children: [
        Padding(
        padding: const EdgeInsets.symmetric(horizontal: 150),
        child: Divider(
          thickness: 4,
          color: Colors.white,
        ),),
            Container(
              height: 50,
              child: Text('Location :${Provider.of<GenerateMaps>(context,listen: true).getMiainAddress}',style: TextStyle(
                color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold
              ),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  height: MediaQuery.of(context).size.height*.65,
                  width: MediaQuery.of(context).size.width,
                child: Provider.of<GenerateMaps>(context,listen: false).fetchMaps()
              ),
            )
          ],
        ),
        height: MediaQuery.of(context).size.height*.80,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Color(0xFF191531)
        ),
      );
    });
  }
  handlePaymentSuccess(BuildContext context,PaymentSuccessResponse paymentSuccessResponse){
return showResponse(context, paymentSuccessResponse.paymentId);
  }
  handlePaymentError(BuildContext context,PaymentFailureResponse paymentFailureResponse){
    return showResponse(context, paymentFailureResponse.message);
  }
  handleExtraWaller(BuildContext context,ExternalWalletResponse externalWalletResponse){
    return showResponse(context, externalWalletResponse.walletName);
  }
  showResponse(BuildContext context,String response){
    return showModalBottomSheet(context: context, builder:(context){
      return Container(
        height: 100,
        width: 400,
        child: Text('the response is $response',style: TextStyle(
          color: Colors.white,fontSize: 24
        ),),
      );
    });
  }


}