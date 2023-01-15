import 'package:flutter_application_1/models/clube.dart';
import 'package:flutter_application_1/models/jogador.dart';

class Contrato {
  Jogador jogador;   
  Clube clube; 
  DateTime inicioContrato;
  DateTime fimContrato;

  Contrato({
    required this.jogador, 
    required this.clube, 
    required this.inicioContrato, 
    required this.fimContrato,
  });

  @override
  String toString() {
    return '${jogador.nomeCamisola} (${clube.sigla})';
  }
}