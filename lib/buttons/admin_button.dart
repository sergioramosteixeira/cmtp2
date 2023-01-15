import 'package:flutter/material.dart';

class AdminButton extends StatelessWidget{
  final VoidCallback _codeToRun;
  final _text;

  AdminButton(this._codeToRun, this._text);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _codeToRun,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, 
        backgroundColor: Colors.green, 
        padding: const EdgeInsets.all(50), 
        disabledForegroundColor: Colors.lightGreen.withOpacity(0.38), 
        disabledBackgroundColor: Colors.lightGreen.withOpacity(0.12),
        shadowColor: Colors.green,
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