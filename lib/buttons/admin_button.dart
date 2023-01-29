import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/addclube.dart';
import 'package:flutter_application_1/screens/addjogador.dart';
import 'package:flutter_application_1/screens/addjogo.dart';
import 'package:flutter_application_1/screens/adminscreen.dart';
import 'package:flutter_application_1/screens/clubesinscritos.dart';

import '../screens/jogadoresinscritos.dart';

class AdminButton extends StatelessWidget{
  final _text;

  AdminButton(this._text);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (){ 
        switch (_text) {
          case 'Admin':
            Navigator.pushNamed(context, AdminScreen.routeName);
            AdminScreen(); 
            break;
          case 'Adicionar Clubes':
            Navigator.pushNamed(context, AddClube.routeName);
            AddClube(); 
            break;
          case 'Adicionar Jogos':
            Navigator.pushNamed(context, AddJogo.routeName);
            AddJogo(); 
            break;
          case 'Adicionar Jogadores':
            Navigator.pushNamed(context, AddJogador.routeName);
            AddJogador(); 
            break;
          case 'Clubes Inscritos':
            Navigator.pushNamed(context, ClubesInscritos.routeName);
            ClubesInscritos(); 
            break;
          case 'Jogadores Inscritos':
            Navigator.pushNamed(context, JogadoresInscritos.routeName);
            JogadoresInscritos(); 
            break;
          default:
        }

      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, 
        backgroundColor: Colors.green.withOpacity(0.5), 
        padding: const EdgeInsets.all(15), 
        disabledForegroundColor: Colors.lightGreen.withOpacity(0.38), 
        disabledBackgroundColor: Colors.lightGreen.withOpacity(0.12),
        shadowColor: Colors.green,
        textStyle: const TextStyle(
          fontSize: 24,
          fontFamily: 'Changa',
        )
      ), 
      child: Text(
        _text,
      ),
    );
  }
}