import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/leaguehome.dart';

class SabsegButton extends StatelessWidget{
  final VoidCallback _codeToRun;
  final _text;

  SabsegButton(this._codeToRun, this._text);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (){ 
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LeagueHome(logo: "sabseg")));
        LeagueHome(logo: "sabseg"); 
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
          Image.network(
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