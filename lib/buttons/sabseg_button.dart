import 'package:flutter/material.dart';

class SabsegButton extends StatelessWidget{
  final VoidCallback _codeToRun;
  final _text;

  SabsegButton(this._codeToRun, this._text);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _codeToRun,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, 
        backgroundColor: Colors.blue, 
        padding: const EdgeInsets.all(50), 
        disabledForegroundColor: Colors.lightBlue.withOpacity(0.38), 
        disabledBackgroundColor: Colors.lightBlue.withOpacity(0.12),
        shadowColor: Colors.blue,
        textStyle: const TextStyle(
          fontSize: 20,
        )
      ), 
      child: Text(
        _text,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}