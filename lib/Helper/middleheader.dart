import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pizza/Serivces/mangedata.dart';
import 'package:pizza/Views/details.dart';
import 'package:provider/provider.dart';

class MiddleeHeiper extends ChangeNotifier{
  Widget textFav(){
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: RichText(text: TextSpan(
          text: 'Favourite',style: TextStyle(
          shadows: [
            BoxShadow(
              color: Colors.black,blurRadius: 1
            )
          ],
          fontSize: 29,fontWeight: FontWeight.bold,color: Colors.white),
          children:<TextSpan> [
            TextSpan(
              text: '  dishes',style: TextStyle(
                shadows: [
                  BoxShadow(
                      color: Colors.grey,blurRadius: 0
                  )
                ],
                fontSize: 22,fontWeight: FontWeight.w600,color: Colors.grey),),

          ]
      )),
    );
  }
  Widget textbus(){
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: RichText(text: TextSpan(
          text: 'Business',style: TextStyle(
          shadows: [
            BoxShadow(
                color: Colors.black,blurRadius: 1
            )
          ],
          fontSize: 29,fontWeight: FontWeight.bold,color: Colors.white),
          children:<TextSpan> [
            TextSpan(
              text: '  lunch',style: TextStyle(
                shadows: [
                  BoxShadow(
                      color: Colors.grey,blurRadius: 0
                  )
                ],
                fontSize: 22,fontWeight: FontWeight.w600,color: Colors.grey),),

          ]
      )),
    );
  }
  Widget dataFav(BuildContext context,String collection){
    return Container(
      height: 300,
      child: FutureBuilder(
        future: Provider.of<MangeData>(context,listen:false).fetchData(collection),
        builder: (context,snapshot){
          print(snapshot.data);
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(
              child: Lottie.asset("animation/delivery.json"),
            );
          }
          return ListView.builder(

              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context,int index){
            return GestureDetector(
              onTap: (){
                Navigator.pushReplacement(context,PageTransition(child: Details(
                  queryDocumentSnapshot: snapshot.data[index],
                ), type: PageTransitionType.topToBottom));

              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 300,
                  width: 200,

                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.8),
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.lightBlueAccent,
                        blurRadius: 2,
                        spreadRadius: 2
                      )
                    ]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left:10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            SizedBox(


                              height: 180,
                              child: Image.network(snapshot.data[index].data()['image'],),
                            ),
                            Positioned(
                               left: 140,
                                                                child: IconButton(icon:Icon(EvaIcons.heart,color: Colors.red,),onPressed: (){},))
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(top: 8),child: Text(snapshot.data[index].data()['name'],style: TextStyle(
                          fontSize: 22,fontWeight: FontWeight.w200,color: Colors.black
                        ),),),
                        Padding(padding: EdgeInsets.only(top: 4),child: Text(snapshot.data[index].data()['category'],style: TextStyle(
                            fontSize: 16,fontWeight: FontWeight.bold,color: Colors.cyan
                        ),),),
                        Padding(
                          padding: const EdgeInsets.only(top:4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.star,color: Colors.yellow,),
                                  Text(snapshot.data[index].data()['ratings'],style: TextStyle(
                                      fontSize: 16,fontWeight: FontWeight.w700,color: Colors.grey
                                  ),)
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left:40),
                                child: Row(
                                  children: [
                                    Icon(FontAwesomeIcons.rupeeSign,size: 12,),
                                    Text(snapshot.data[index].data()['price'].toString(),style: TextStyle(
                                        fontSize: 16,fontWeight: FontWeight.w700,color: Colors.black
                                    ),)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )

                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          itemCount: snapshot.data.length);
        },
      ),
    );
  }
  Widget dataBusness(BuildContext context ,String collection){
    return Container(
      height: 400,
      child: FutureBuilder(
        future: Provider.of<MangeData>(context,listen:false).fetchData(collection),
        builder: (context,snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Lottie.asset("animation/delivery.json"),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context,int index){
            return GestureDetector(
              onTap: (){
                Navigator.pushReplacement(context,PageTransition(child: Details(
                  queryDocumentSnapshot: snapshot.data[index],
                ), type: PageTransitionType.topToBottom));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(

                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.8),
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.redAccent,
                            blurRadius: 2,
                            spreadRadius: 2
                        )
                      ]
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:4),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(snapshot.data[index].data()['name'],style: TextStyle(
                                fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black
                            ),),
                            Text(snapshot.data[index].data()['category'],style: TextStyle(
                                fontSize: 14,fontWeight: FontWeight.bold,color: Colors.cyan
                            ),),
                            Text(snapshot.data[index].data()['notPrice'].toString(),style: TextStyle(decoration: TextDecoration.lineThrough,
                                fontSize: 14,fontWeight: FontWeight.w500,color: Colors.black
                            ),),
                            Row(
                              children: [
                                Icon(FontAwesomeIcons.rupeeSign,size:14),
                                Text(snapshot.data[index].data()['price'].toString(),style: TextStyle(
                                    fontSize: 16,fontWeight: FontWeight.w200,color: Colors.black
                                ),),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 200,
                          child: Image.network(snapshot.data[index].data()['image']),

                        ),
                      )
                    ],
                    
                  ),
                  
                ),
              ),
            );
          });
        }
      ),
    );

  }
}