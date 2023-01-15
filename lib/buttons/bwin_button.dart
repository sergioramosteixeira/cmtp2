import 'package:flutter/material.dart';

class BwinButton extends StatelessWidget{
  final VoidCallback _codeToRun;
  final _text;

  BwinButton(this._codeToRun, this._text);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _codeToRun,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.orange, 
        backgroundColor: Colors.black, 
        padding: const EdgeInsets.all(50), 
        disabledForegroundColor: Colors.yellow.withOpacity(0.38), 
        disabledBackgroundColor: Colors.yellow.withOpacity(0.12),
        shadowColor: Colors.black12,
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