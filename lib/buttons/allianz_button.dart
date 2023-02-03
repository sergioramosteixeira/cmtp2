import 'package:flutter/material.dart';

import '../screens/leaguehome.dart';

class AllianzButton extends StatelessWidget{
  final _text;

  AllianzButton(this._text);

  @override
  Widget build(BuildContext context) {
  //Classe do Botão da Taça Allianz Genérico - mostrado nos diversos menus
    return ElevatedButton(
      onPressed: (){ 
        Navigator.pushNamed(context, LeagueHome.routeName+"/Allianz");
        LeagueHome(liga: "Allianz"); 
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, 
        backgroundColor: Colors.deepPurple.withOpacity(0.5), 
        padding: const EdgeInsets.fromLTRB(50,0,50,0), 
        disabledForegroundColor: Colors.purple.withOpacity(0.38), 
        disabledBackgroundColor: Colors.purple.withOpacity(0.12),
        shadowColor: Colors.deepPurple,
        textStyle: const TextStyle(
          fontSize: 24,
          fontFamily: 'Changa',
        )
      ), 
      child: Row(
        children: <Widget>[
          Image.asset(
            'img/allianz.png',
            height: 100,
          ),
          Expanded(
            child: Center(
              child: Text(
                _text,
              ),
            ),
          ),
        ],
      ),
    );
  }
}