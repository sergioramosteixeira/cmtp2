import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/leaguehome.dart';

class SabsegButton extends StatelessWidget{
  final _text;

  SabsegButton(this._text);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (){ 
        Navigator.pushNamed(context, LeagueHome.routeName+"/Sabseg");
        LeagueHome(liga: "Sabseg"); 
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, 
        backgroundColor: Colors.blue.withOpacity(0.5), 
        padding: const EdgeInsets.fromLTRB(50,0,50,0), 
        disabledForegroundColor: Colors.lightBlue.withOpacity(0.38), 
        disabledBackgroundColor: Colors.lightBlue.withOpacity(0.12),
        shadowColor: Colors.blue,
        textStyle: const TextStyle(
          fontSize: 24,
          fontFamily: 'Changa',
        )
      ), 
      child: Row(
        children: <Widget>[
          Image.asset(
            'img/sabseg.png',
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