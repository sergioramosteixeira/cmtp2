import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/leaguehome.dart';

class BwinButton extends StatelessWidget{
  final VoidCallback _codeToRun;
  final _text;

  BwinButton(this._codeToRun, this._text);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (){ 
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LeagueHome(logo: "bwin")));
        LeagueHome(logo: "bwin"); 
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.orange, 
        backgroundColor: Colors.black.withOpacity(0.5), 
        padding: const EdgeInsets.fromLTRB(50,0,50,0), 
        disabledForegroundColor: Colors.yellow.withOpacity(0.38), 
        disabledBackgroundColor: Colors.yellow.withOpacity(0.12),
        shadowColor: Colors.black12,
        textStyle: const TextStyle(
          fontSize: 24,
          fontFamily: 'Changa',
        )
      ), 
      child: Row(
        children: <Widget>[
          Image.network(
            'img/bwin.png',
            height: 100,
          ),
          const Expanded(
            child: Center(
              child: Text("Liga BWIN"),
            ),
          ),
        ],
      ),
    );
  }
}