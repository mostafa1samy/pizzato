import 'package:flutter/material.dart';
import 'package:pizza/Helper/footer.dart';
import 'package:pizza/Helper/helper.dart';
import 'package:pizza/Helper/middleheader.dart';
import 'package:pizza/Serivces/map.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
 Provider.of<GenerateMaps>(context,listen: false).getCurrentLocation();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      floatingActionButton: Footer().floatActionButton(context),
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Header().appBar(context),
                Header().headerText(),
                Header().headerMenu(context),
               // Divider(),
                MiddleeHeiper().textFav(),
                MiddleeHeiper().dataFav(context, 'favourite'),
                MiddleeHeiper().textbus(),
                MiddleeHeiper().dataBusness(context, 'business')

              ],
            ),
          ),
        ),
      ),
    );
  }
}
