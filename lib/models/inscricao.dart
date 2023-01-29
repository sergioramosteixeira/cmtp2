import 'package:flutter_application_1/models/clube.dart';
import 'package:flutter_application_1/models/classificacao.dart';
import 'package:flutter_application_1/models/jogador.dart';

class Inscricao {
  Jogador jogador;   
  Clube clube;
  int epoca;
  String passaporte;

  Inscricao({
    required this.jogador, 
    required this.clube,
    required this.epoca, 
    required this.passaporte,
  });

  @override
  String toString() {
    return '${jogador.nomeCamisola} (${clube.sigla})';
  }
}