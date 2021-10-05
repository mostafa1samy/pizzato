import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pizza/MinViews/map.dart';
import 'package:pizza/Serivces/mangedata.dart';
import 'package:pizza/Serivces/map.dart';
import 'package:pizza/Views/splashscreen.dart';
import 'package:pizza/providers/authentiction.dart';
import 'package:pizza/providers/pyment.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'homepage.dart';

class MyCart extends StatefulWidget {
  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart>{
  int total=0;
  Razorpay razorpay;
  @override
  void initState() {
   razorpay= Razorpay();
   razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
   Provider.of<PaymentHelper>(context,listen: false).handlePaymentSuccess
   );
   razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
       Provider.of<PaymentHelper>(context,listen: false).handlePaymentError
   );
   razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
       Provider.of<PaymentHelper>(context,listen: false).handleExtraWaller  );
    super.initState();
  }
  @override
  void dispose() {
   razorpay.clear();
    super.dispose();
  }
  Future checkMeOut()async{
    var options={
      'key':'rzp_test_Q8YITRLMaCKXWy',
      'amount':total,
      'name':Provider.of<Authentiction>(context,listen: false).getUerEmail==null?userEmail:
      Provider.of<Authentiction>(context,listen: false).getUerEmail ,
      'description':'Payment',
      'prefill':{
        'contact':'8888888888',
    'email':Provider.of<Authentiction>(context,listen: false).getUerEmail,
    },
    'external':{
        'wallet':['paytm']
    }
    };
    try{
      razorpay.open(options);
    }
    catch(e){
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // floatingActionButton: floatActioButton(),
      backgroundColor: Colors.white,
      body: Container(
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
        child: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              appBar(context),
              textHeader(),
              cartData(),
              //shippingDetails( context),
              //billingData()
              Container(
                height: 330,
                width: 400,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/loginsheet.png')
                  )
                ),
              )

            ],
          ),
        ),
      ),
    );
  }

  Widget billingData(){
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade500,blurRadius: 5,spreadRadius: 3
              )
            ]
        ),
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Subtotal',style: TextStyle(fontSize: 20,color: Colors.grey),),
                Row(
                  children: [
                    Icon(FontAwesomeIcons.rupeeSign,color: Colors.grey,size: 16,),
                    Text('300.00',style: TextStyle(fontSize: 16,color: Colors.grey),),
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Delivery Charges',style: TextStyle(fontSize: 20,color: Colors.grey),),
                Row(
                  children: [
                    Icon(FontAwesomeIcons.rupeeSign,color: Colors.grey,size: 16,),
                    Text('30.00',style: TextStyle(fontSize: 16,color: Colors.grey),),
                  ],
                )
              ],
            ), Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Total',style: TextStyle(fontSize: 20,color: Colors.black),),
                  Row(
                    children: [
                      Icon(FontAwesomeIcons.rupeeSign,color: Colors.grey,size: 18,),
                      Text('330.00',style: TextStyle(fontSize: 20,color: Colors.black),),
                    ],
                  )
                ],
              ),
            )
          ],
        ),

      ),
    );
  }
  Widget floatActioButton(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [

        GestureDetector(onTap: (){},
          child: Container(
            width: 250,
            height: 50,
            decoration: BoxDecoration(color: Colors.red.shade500,borderRadius: BorderRadius.circular(50)),
            child: Center(
              child:  Text(
                'Place Order',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),
              ),
            ),
          ),),

      ],
    );
  }

  Widget cartData(){
    return SizedBox(
      height: 250,
      child:StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('myOrders').snapshots(),
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(
              child: Lottie.asset('animation/delivery.json'),
            );}
            else{
              return ListView(

                children: snapshot.data.docs.map((DocumentSnapshot documentSnapshot){
                  total=documentSnapshot.data()['price']+20;
                  return GestureDetector(
                      onLongPress: (){
                        placeOrder(context, documentSnapshot);
                        print(total);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.8),
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.lightBlueAccent,blurRadius: 2,spreadRadius: 2
                              )
                            ]
                        ),
                        height: 200,
                        width: 400,
                        child: Row(
                          children: [
                            SizedBox(

                              child: Image.network(documentSnapshot.data()['image']),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(documentSnapshot.data()['name']
                                  ,style: TextStyle(color: Colors.black87,fontSize: 22,fontWeight: FontWeight.bold),),
                                Text('Price : ${documentSnapshot.data()['price'].toString()}'
                                  ,style: TextStyle(color: Colors.black87,fontSize: 21,fontWeight: FontWeight.bold),),
                                Text('Onion : ${documentSnapshot.data()['onion'].toString()}'
                                  ,style: TextStyle(color: Colors.black87,fontSize: 18,),),
                                Text('Beacon : ${documentSnapshot.data()['beacon'].toString()}'
                                  ,style: TextStyle(color: Colors.black87,fontSize: 18,),),
                                Text('Cheese : ${documentSnapshot.data()['cheese'].toString()}'
                                  ,style: TextStyle(color: Colors.black87,fontSize: 18,),),
                                CircleAvatar(
                               child:Text(documentSnapshot.data()['size'].toString()
                                    ,style: TextStyle(color: Colors.white,fontSize: 18,),),
                                )

                              ],
                            )
                          ],
                        ),
                      ),

                  );
                } ).toList(),
              );

          }
          }

      )
    );
  }
  placeOrder(BuildContext context,DocumentSnapshot documentSnapshot){
    return showModalBottomSheet(
      context: context,
      builder: (context){
        return Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 150),
                child: Divider(
                  thickness: 4,
                  color: Colors.white,
                ),
              ),SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                         height: 30,
                          child: Text('Time : ${Provider.of<PaymentHelper>(context,listen: true).deleveryTime.format(context)}',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),)),
                      Container(
                          height: 30,
                          child: Text('Location : ${Provider.of<GenerateMaps>(context,listen: true).getMiainAddress}',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),))
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    backgroundColor: Colors.redAccent,
                      onPressed: (){
                      Provider.of<PaymentHelper>(context,listen: false).selectTime(context);
                      },
                      child:  Icon(FontAwesomeIcons.clock,color: Colors.white), ),
                  //IconButton(icon: Icon(FontAwesomeIcons.clock,color: Colors.white), onPressed: (){})
                  FloatingActionButton(
                    backgroundColor: Colors.lightBlueAccent,
                    onPressed: (){
                      Provider.of<PaymentHelper>(context,listen: false).selectLoction(context);
                    },
                    child:  Icon(FontAwesomeIcons.mapPin,color: Colors.white), ),
                  FloatingActionButton(
                    backgroundColor: Colors.lightGreenAccent,
                    onPressed: ()async{
                     await checkMeOut().whenComplete(() {
                       Provider.of<PaymentHelper>(context,listen: false).showCheckOutButtonMethod();
                     });
                    },
                    child:  Icon(FontAwesomeIcons.paypal,color: Colors.white), ),
                ],
              ),
              Provider.of<PaymentHelper>(context,listen: false).showCheckOutButton?MaterialButton(onPressed: ()async{
                await FirebaseFirestore.instance.collection('adminCollections').add({
                 'username':Provider.of<Authentiction>(context,listen: false).getUerEmail,
//                  ==null?userEmail:
//                  Provider.of<Authentiction>(context,listen: false).getUerEmail,
                  'time':Provider.of<PaymentHelper>(context,listen: false).deleveryTime.format(context),
                  'address':Provider.of<GenerateMaps>(context,listen: false).getMiainAddress,
                  'image':documentSnapshot.data()['image'],
                  'pizza':documentSnapshot.data()['name'],
                  'price':documentSnapshot.data()['price'],
                  'size':documentSnapshot.data()['size'],
                  'onion':documentSnapshot.data()['onion'],
                  'cheese':documentSnapshot.data()['cheese'],
                  'beacon':documentSnapshot.data()['beacon'],
                  'location':Provider.of<GenerateMaps>(context,listen: false).getGeoPoint



                });
              },
              child: Text('Place Order',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
              ):
              Container(
                height: 0,
                width: 0,

              )
            ],
          ),
          height: MediaQuery.of(context).size.height*.4,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Color(0xFF191531)
          ),
        );
      }
    );
  }
  Widget shippingDetails(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade500,blurRadius: 5,spreadRadius: 3
          )
        ]
      ),
      height: 130,
      width: 400,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(FontAwesomeIcons.locationArrow),
                    Padding(
                      padding: const EdgeInsets.only(left:8),
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: 250
                        ),
                        child: Text(Provider.of<GenerateMaps>(context,listen: false).getMiainAddress),
                      ),
                    )
                  ],
                ),
                IconButton(icon: Icon(Icons.edit), onPressed: (){
                  Navigator.pushReplacement(context, PageTransition(child: Map(), type: PageTransitionType.rightToLeftWithFade));
                })
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(FontAwesomeIcons.clock),
                  Padding(
                    padding: const EdgeInsets.only(left:8),
                    child: Container(
                      constraints: BoxConstraints(
                          maxWidth: 250
                      ),
                      child: Text('6pm - 8pm'),
                    ),
                  )
                ],
              ),
              IconButton(icon: Icon(Icons.edit), onPressed: (){})
            ],
          )
        ],
      ),
    );
  }
  Widget appBar(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(top:40),
      child: Row(
        //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(icon: Icon(Icons.arrow_back_ios,color:Colors.white), onPressed:(){
            Navigator.pushReplacement(context, PageTransition(child: HomePage(), type: PageTransitionType.rightToLeftWithFade));
          }),
          Padding(
            padding: const EdgeInsets.only(left:300),
            child: IconButton(icon: Icon(FontAwesomeIcons.trashAlt,color: Colors.red,), onPressed:(){
              Provider.of<MangeData>(context,listen: false).delet(context);
              //Navigator.pushReplacement(context, PageTransition(child: HomePage(), type: PageTransitionType.rightToLeftWithFade));
            }),
          )
        ],
      ),
    );

  }
  Widget textHeader(){
    return Column(
      children: [
        Text('your',style: TextStyle(
          color: Colors.grey,fontSize: 22
        ),),
        Text('Cart',style: TextStyle(
            color: Colors.white,fontSize: 46,fontWeight: FontWeight.bold
        ),)
      ],
    );

  }
}
