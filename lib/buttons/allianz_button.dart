import 'package:flutter/material.dart';

class AllianzButton extends StatelessWidget{
  final VoidCallback _codeToRun;
  final _text;

  AllianzButton(this._codeToRun, this._text);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _codeToRun,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, 
        backgroundColor: Colors.deepPurple, 
        padding: const EdgeInsets.all(50), 
        disabledForegroundColor: Colors.purple.withOpacity(0.38), 
        disabledBackgroundColor: Colors.purple.withOpacity(0.12),
        shadowColor: Colors.deepPurple,
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