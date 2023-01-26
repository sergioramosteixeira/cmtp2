import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/addclube.dart';
import 'package:flutter_application_1/screens/addjogo.dart';
import 'package:flutter_application_1/screens/adminscreen.dart';

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
          default:
        }
        if(_text=='Admin'){
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