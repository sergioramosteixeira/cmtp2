import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/clubes.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/screens/addclube.dart';
import 'package:flutter_application_1/screens/addjogador.dart';
import 'package:flutter_application_1/screens/addjogo.dart';
import 'package:flutter_application_1/screens/adminscreen.dart';
import 'package:flutter_application_1/screens/clubesinscritos.dart';
import 'package:flutter_application_1/screens/jogadoresinscritos.dart';
import 'package:flutter_application_1/screens/leaguehome.dart';
import 'package:flutter_application_1/screens/mainmenu.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
        AddJogador.routeName: (context) => AddJogador(),
        ClubesInscritos.routeName: (context) => ClubesInscritos(),
        JogadoresInscritos.routeName: (context) => JogadoresInscritos(),
      },
    );
  }
}

