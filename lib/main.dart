import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/screens/addclube.dart';
import 'package:flutter_application_1/screens/addjogo.dart';
import 'package:flutter_application_1/screens/adminscreen.dart';
import 'package:flutter_application_1/screens/leaguehome.dart';
import 'package:flutter_application_1/screens/mainmenu.dart';
//import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /*FirebaseFirestore.instance
    .collection("clubes")
    .doc("fc porto")
    .set({"campo1": "valor1", "campo2": "valor2"});*/

  runApp(App());
}


class App extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Changa'),
      initialRoute: MainMenu.routeName,
      routes: {
        MainMenu.routeName: (context) => MainMenu(),
        LeagueHome.routeName: (context) => LeagueHome(logo: "bwin"),
        AdminScreen.routeName: (context) => AdminScreen(),
        AddClube.routeName: (context) => AddClube(),
        AddJogo.routeName: (context) => AddJogo(),
      },
    );
  }
}

