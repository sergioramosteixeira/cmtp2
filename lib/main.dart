import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/clubes.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/screens/addclube.dart';
import 'package:flutter_application_1/screens/addjogador.dart';
import 'package:flutter_application_1/screens/addjogo.dart';
import 'package:flutter_application_1/screens/adminscreen.dart';
import 'package:flutter_application_1/screens/clubescreen.dart';
import 'package:flutter_application_1/screens/clubesinscritos.dart';
import 'package:flutter_application_1/screens/jogadoresinscritos.dart';
import 'package:flutter_application_1/screens/jogadorscreen.dart';
import 'package:flutter_application_1/screens/leaguehome.dart';
import 'package:flutter_application_1/screens/mainmenu.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/screens/relatoriocontrolodoping.dart';
import 'package:flutter_application_1/screens/relatoriorenovacoes.dart';

import 'screens/relatorioinscritos.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(App());
}


class App extends StatelessWidget {
  String optionalArg = "";
  String optionalArg2 = "";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Changa'),
      initialRoute: MainMenu.routeName,
      onGenerateRoute: (settings) {
        final List<String> pathElements = settings.name!.split('/');
        if ('/${pathElements[1]}' == ClubeScreen.routeName) {
          if (pathElements[2]!=null){
            optionalArg = pathElements[2];
            return MaterialPageRoute(
              builder: (context) => ClubeScreen(clube: optionalArg),
            );
          } 
          else Navigator.pushNamed(context, MainMenu.routeName);
        }
        if ('/${pathElements[1]}' == AddClube.routeName) {
          if (pathElements[2]!=null){
            optionalArg = pathElements[2];
            return MaterialPageRoute(
              builder: (context) => AddClube(clube: optionalArg),
            );
          } 
          else Navigator.pushNamed(context, AddClube.routeName);
        }
        if ('/${pathElements[1]}' == AddJogador.routeName) {
          if (pathElements[2]!=null){
            optionalArg = pathElements[2];
            return MaterialPageRoute(
              builder: (context) => AddJogador(passaporte: optionalArg),
            );
          } 
          else Navigator.pushNamed(context, AddClube.routeName);
        }
        if ('/${pathElements[1]}' == ClubesInscritos.routeName) {
          if (pathElements[2]!=null){
            optionalArg = pathElements[2];
            return MaterialPageRoute(
              builder: (context) => ClubesInscritos(liga: optionalArg),
            );
          } 
          else Navigator.pushNamed(context, ClubesInscritos.routeName);
        }
        if ('/${pathElements[1]}' == AddJogo.routeName) {
          if (pathElements[2]!=null){
            optionalArg = pathElements[2];
            return MaterialPageRoute(
              builder: (context) => AddJogo(liga: optionalArg),
            );
          } 
          else Navigator.pushNamed(context, ClubesInscritos.routeName);
        }
        if ('/${pathElements[1]}' == JogadorScreen.routeName) {
          if (pathElements[2]!=null){
            optionalArg = pathElements[2];
            optionalArg2 = pathElements[3];
            return MaterialPageRoute(
              builder: (context) => JogadorScreen(passaporte: optionalArg, jogador: optionalArg2,),
            );
          } 
          else Navigator.pushNamed(context, MainMenu.routeName);
        }
        if ('/${pathElements[1]}' == JogadoresInscritos.routeName) {
          if (pathElements[2]!=null && pathElements[3]!=null){
            optionalArg = pathElements[3];
            return MaterialPageRoute(
              builder: (context) => (pathElements[2]=="clube") ? JogadoresInscritos(clube: optionalArg) : JogadoresInscritos(passaporte: optionalArg),
            );
          } 
          else Navigator.pushNamed(context, JogadoresInscritos.routeName);
        }
      },
      routes: {
        MainMenu.routeName: (context) => MainMenu(),
        LeagueHome.routeName+"/BWIN": (context) => LeagueHome(liga: "BWIN"),
        LeagueHome.routeName+"/Sabseg": (context) => LeagueHome(liga: "Sabseg"),
        LeagueHome.routeName+"/Allianz": (context) => LeagueHome(liga: "Allianz"),
        AdminScreen.routeName: (context) => AdminScreen(),
        AddClube.routeName: (context) => AddClube(),
        AddJogo.routeName: (context) => AddJogo(),
        AddJogador.routeName: (context) => AddJogador(),
        ClubesInscritos.routeName: (context) => ClubesInscritos(),
        JogadoresInscritos.routeName: (context) => JogadoresInscritos(),
        ClubeScreen.routeName: (context) => ClubeScreen(clube: optionalArg),
        JogadorScreen.routeName: (context) => JogadorScreen(passaporte: optionalArg, jogador: optionalArg2,),
        RelatorioInscritos.routeName: (context) => RelatorioInscritos(),
        RelatorioRenovacoes.routeName: (context) => RelatorioRenovacoes(),
        RelatorioControloDoping.routeName: (context) => RelatorioControloDoping(),
      },
    );
  }
}

