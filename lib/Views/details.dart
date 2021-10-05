import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pizza/Views/homepage.dart';
import 'package:pizza/Views/mycart.dart';
import 'package:pizza/providers/calculation.dart';
import 'package:provider/provider.dart';

class Details extends StatefulWidget {
  final QueryDocumentSnapshot queryDocumentSnapshot;
  Details({this.queryDocumentSnapshot});
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int cheeseValue=0;
  int beaconValue=0;
  int onionValue=0;
  int totalitems=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: floatActioButton(),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            appBar(context),
            pizzaImage(),
            middelData(),
            footerDetails(),


          ],
        ),
      ),
    );
  }
  Widget floatActioButton(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [

        GestureDetector(onTap: (){
           Provider.of<Calculation>(context,listen: false).addToCart(context, {
             'image':widget.queryDocumentSnapshot['image'],
             'name':widget.queryDocumentSnapshot['name'],
             'price':widget.queryDocumentSnapshot['price'],
             'onion':Provider.of<Calculation>(context,listen: false).getOnioneValue,
             'cheese':Provider.of<Calculation>(context,listen: false).getCheeseValue,
             'beacon':Provider.of<Calculation>(context,listen: false).getBeaconValue,
             'size':Provider.of<Calculation>(context,listen: false).gtSize,
           });
        },
        child: Container(
          width: 250,
          height: 50,
          decoration: BoxDecoration(color: Colors.lightBlueAccent,borderRadius: BorderRadius.circular(50)),
          child: Center(
            child:  Text(
             'Add to cart',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),
            ),
          ),
        ),),
      Stack(
        children: [
          FloatingActionButton(
            backgroundColor: Colors.lightBlue,
            onPressed: (){
            Navigator.pushReplacement(context,PageTransition(child: MyCart(), type:PageTransitionType.rightToLeft));
          },child: Icon(Icons.shopping_basket,color: Colors.black,),),
          Positioned(
            left: 35,
              child: CircleAvatar(
                backgroundColor: Colors.white,
            radius: 10,
            child: Text(Provider.of<Calculation>(context,listen: false).getCartData.toString(),
            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
          ))
        ],
      )
      ],
    );
  }
  Widget pizzaImage(){
    return Center(
      child: SizedBox(
        height: 280,
        child: Container(
          child: Image.network(widget.queryDocumentSnapshot['image']),
          decoration: BoxDecoration(
            shape: BoxShape.circle
          ),
        ),
      ),
    );
  }
  Widget middelData(){
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.star,color:Colors.yellow,size: 20,),
            Padding(padding: EdgeInsets.only(left: 10),child: Text(
              widget.queryDocumentSnapshot['ratings'],style: TextStyle(fontSize: 20,color: Colors.grey.shade500),
            ),)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: 300),
              child: Text(
                widget.queryDocumentSnapshot['name'],style: TextStyle(fontSize: 36,color: Colors.grey.shade500,fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              children: [
                Icon(FontAwesomeIcons.rupeeSign,size: 20,color: Colors.cyan,),
                Text(
                  widget.queryDocumentSnapshot['price'].toString(),style: TextStyle(fontSize: 20,color: Colors.cyan,fontWeight: FontWeight.bold),
                )
              ],
            )
          ],
        )
      ],
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
                 Provider.of<Calculation>(context,listen: false).removeAllData();
              //Navigator.pushReplacement(context, PageTransition(child: HomePage(), type: PageTransitionType.rightToLeftWithFade));
            }),
          )
        ],
      ),
    );

  }
  Widget footerDetails(){
    return SizedBox(
      height: 300,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.8),
                borderRadius: BorderRadius.all(Radius.circular(40)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade500,blurRadius: 2,spreadRadius: 2
                  )
                ]
              ),
              width: 400,
              child: Padding(
                padding: const EdgeInsets.only(top:40,right: 20,left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                     'Add more stuff',style: TextStyle(fontSize: 24,color: Colors.black,fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                        'Cheese',style: TextStyle(fontSize: 22,color: Colors.grey.shade500),
                        ),
                        Row(
                          children: [
                            IconButton(icon: Icon(EvaIcons.minus),onPressed: (){
                              Provider.of<Calculation>(context,listen: false).minusCheese();
                            },),
                            Text(
                              Provider.of<Calculation>(context,listen: true).getCheeseValue.toString(),style: TextStyle(fontSize: 20,color: Colors.grey.shade500),
                            ),
                            IconButton(icon: Icon(EvaIcons.plus),onPressed: (){
                              Provider.of<Calculation>(context,listen: false).addCheese();
                            },),

                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Onion',style: TextStyle(fontSize: 22,color: Colors.grey.shade500),
                        ),
                        Row(
                          children: [
                            IconButton(icon: Icon(EvaIcons.minus),onPressed: (){
                              Provider.of<Calculation>(context,listen: false).minusOnion();
                            },),
                            Text(
                              Provider.of<Calculation>(context,listen: true).getOnioneValue.toString(),style: TextStyle(fontSize: 20,color: Colors.grey.shade500),
                            ),
                            IconButton(icon: Icon(EvaIcons.plus),onPressed: (){
                              Provider.of<Calculation>(context,listen: false).addOnion();
                            },),

                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Beacon',style: TextStyle(fontSize: 22,color: Colors.grey.shade500),
                        ),
                        Row(
                          children: [
                            IconButton(icon: Icon(EvaIcons.minus),onPressed: (){
                              Provider.of<Calculation>(context,listen: false).minusBeacon();
                            },),
                            Text(
                              Provider.of<Calculation>(context,listen: true).getBeaconValue.toString(),style: TextStyle(fontSize: 20,color: Colors.grey.shade500),
                            ),
                            IconButton(icon: Icon(EvaIcons.plus),onPressed: (){
                              Provider.of<Calculation>(context,listen: false).addBeacon();
                            },),

                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: (){
                  Provider.of<Calculation>(context,listen: false).selsctSmallSize();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color:    Provider.of<Calculation>(context,listen: true).smallTapped?Colors.lightBlue: Colors.white,
                    border: Border.all(color: Colors.lightBlue),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(padding: EdgeInsets.all(8),
                  child: Text('S',style: TextStyle(fontSize: 20),),),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Provider.of<Calculation>(context,listen: false).selsctMedunSize();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color:    Provider.of<Calculation>(context,listen: true).meduimTapped?Colors.lightBlue: Colors.white,
                      border: Border.all(color: Colors.lightBlue),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(padding: EdgeInsets.all(8),
                    child: Text('M',style: TextStyle(fontSize: 20),),),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Provider.of<Calculation>(context,listen: false).selsctlargeSize();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color:    Provider.of<Calculation>(context,listen: true).largeTapped?Colors.lightBlue: Colors.white,
                      border: Border.all(color: Colors.lightBlue),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(padding: EdgeInsets.all(8),
                    child: Text('L',style: TextStyle(fontSize: 20),),),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
