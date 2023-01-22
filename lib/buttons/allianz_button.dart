import 'package:flutter/material.dart';

import '../screens/leaguehome.dart';

class AllianzButton extends StatelessWidget{
  final VoidCallback _codeToRun;
  final _text;

  AllianzButton(this._codeToRun, this._text);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (){ 
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LeagueHome(logo: "allianz")));
        LeagueHome(logo: "allianz"); 
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
          Image.network(
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