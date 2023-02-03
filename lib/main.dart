import 'package:flutter/material.dart';
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
  //Assegurar que os widgets são iniciados - Obrigatório para correto funcionamento do Firestore
  WidgetsFlutterBinding.ensureInitialized();
  
  //Iniciar o Firebase com as configurações Default
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //Iniciar a Aplicação
  runApp(App());
}


class App extends StatelessWidget {

  //Variáveis para os argumentos opcionais das rotas.
  String optionalArg = "";
  String optionalArg2 = "";


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Changa'),  //Definição do Tipo de Letra como tema, para ser assumido em toda a aplicação
      initialRoute: MainMenu.routeName,        //Página incial é o MainMenu - definido através do seu nome de rota
      onGenerateRoute: (settings) {
        //Tratamento dos parâmetros passados nas rotas 
        //A rota default é /{nomedapagina}
        //Mas quando se quer passar um parametro pode ser /{nomedapagina}/{parametro1}/{parametro2}
        final List<String> pathElements = settings.name!.split('/');
        if (pathElements.length > 3){
          optionalArg2 = pathElements[3];
          optionalArg = pathElements[2];
          if('/${pathElements[1]}' == JogadorScreen.routeName) {
            return MaterialPageRoute(
              builder: (context) => JogadorScreen(passaporte: optionalArg, jogador: optionalArg2),
            );
          }
          if('/${pathElements[1]}' == JogadoresInscritos.routeName) {
            return MaterialPageRoute(
              builder: (context) => (pathElements[2]=="clube") ? JogadoresInscritos(clube: optionalArg2) : JogadoresInscritos(passaporte: optionalArg2),
            );
          }
        }
        else{
          if (pathElements.length > 2){
            optionalArg = pathElements[2];
            if('/${pathElements[1]}' == ClubeScreen.routeName) {
              return MaterialPageRoute(
                builder: (context) => ClubeScreen(clube: optionalArg),
              );
            }
            if('/${pathElements[1]}' == AddClube.routeName)
            {
              return MaterialPageRoute(
                builder: (context) => AddClube(clube: optionalArg),
              );
            }
            if('/${pathElements[1]}' == AddJogador.routeName)
            {
              return MaterialPageRoute(
                builder: (context) => AddJogador(passaporte: optionalArg),
              );
            }
            if('/${pathElements[1]}' == ClubesInscritos.routeName)
            {
              return MaterialPageRoute(
                builder: (context) => ClubesInscritos(liga: optionalArg),
              );
            }
            if('/${pathElements[1]}' == ClubesInscritos.routeName)
            {
              return MaterialPageRoute(
                builder: (context) => ClubesInscritos(liga: optionalArg),
              );
            }
            if('/${pathElements[1]}' == AddJogo.routeName)
            {
              return MaterialPageRoute(
                builder: (context) => AddJogo(liga: optionalArg),
              );
            }
            if('/${pathElements[1]}' == LeagueHome.routeName)
            {
              return MaterialPageRoute(
                builder: (context) => LeagueHome(liga: optionalArg),
              );
            }
          }
        }
      },
      routes: {
        //Indice de todas as rotas da aplicação
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

