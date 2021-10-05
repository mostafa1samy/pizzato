
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pizza/Serivces/map.dart';
import 'package:pizza/Views/mycart.dart';
import 'package:provider/provider.dart';
class Map extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Provider.of<GenerateMaps>(context,listen: false).fetchMaps(),
          Positioned(
            top: 720,
              left: 50,
              child: Container(
                  height: 80,
                  width: 300,
                  child: Text(Provider.of<GenerateMaps>(context,listen:true).getMiainAddress))),
          Positioned(
              top: 50,
              child: IconButton(
            icon: Icon(Icons.arrow_back_ios_outlined,color: Colors.white,),
            onPressed: (){
              Navigator.pushReplacement(context, PageTransition(child: MyCart(), type: PageTransitionType.rightToLeftWithFade));
            },
          ))
        ],
      ),
    );
  }
}
