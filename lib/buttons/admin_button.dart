import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/addclube.dart';
import 'package:flutter_application_1/screens/addjogador.dart';
import 'package:flutter_application_1/screens/addjogo.dart';
import 'package:flutter_application_1/screens/adminscreen.dart';
import 'package:flutter_application_1/screens/clubesinscritos.dart';
import 'package:flutter_application_1/screens/relatoriocontrolodoping.dart';
import 'package:flutter_application_1/screens/relatorioinscritos.dart';
import 'package:flutter_application_1/screens/relatoriorenovacoes.dart';

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
          case 'Relatório de Jogadores Ativos':
            Navigator.pushNamed(context, RelatorioInscritos.routeName);
            RelatorioInscritos(); 
            break;
          case 'Relatório de Contratos a Expirar':
            Navigator.pushNamed(context, RelatorioRenovacoes.routeName);
            RelatorioRenovacoes(); 
            break;
          case 'Relatório de Controlos Antidoping':
            Navigator.pushNamed(context, RelatorioControloDoping.routeName);
            RelatorioControloDoping(); 
            break;
          default:
        }

      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, 
        backgroundColor: Color.fromARGB(255, 12, 0, 62), 
        padding: const EdgeInsets.all(15), 
        disabledForegroundColor: Color.fromARGB(232, 30, 0, 148), 
        disabledBackgroundColor: Color.fromARGB(232, 30, 0, 148), 
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