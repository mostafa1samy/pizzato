import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pizza/Helper/footer.dart';
import 'package:pizza/Serivces/mangedata.dart';
import 'package:pizza/Views/splashscreen.dart';
import 'package:pizza/adminpanel/service/adminDetailHelper.dart';
import 'package:pizza/adminpanel/view/deliveryoptions.dart';
import 'package:pizza/providers/authentiction.dart';
import 'package:pizza/providers/calculation.dart';
import 'package:pizza/providers/pyment.dart';
import 'package:provider/provider.dart';

import 'Helper/helper.dart';
import 'Helper/middleheader.dart';
import 'Serivces/map.dart';
import 'adminpanel/view/maphelper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider.value(value: Header()),ChangeNotifierProvider.value(value: MiddleeHeiper()),
      ChangeNotifierProvider.value(value: MangeData()), ChangeNotifierProvider.value(value: Footer())
      , ChangeNotifierProvider.value(value: Calculation())
      , ChangeNotifierProvider.value(value: GenerateMaps()), ChangeNotifierProvider.value(value: Authentiction())
      , ChangeNotifierProvider.value(value: PaymentHelper()), ChangeNotifierProvider.value(value: AdminDetailHelper()),
     ChangeNotifierProvider.value(value: MapHelper()), ChangeNotifierProvider.value(value: DeliveryOption()),

    ],
    child: MaterialApp(
      title: 'Pizzato',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        canvasColor: Colors.transparent,

        primarySwatch: Colors.red,
        primaryColor: Colors.redAccent,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    ),);
  }
}


