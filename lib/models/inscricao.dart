import 'package:flutter_application_1/models/clube.dart';
import 'package:flutter_application_1/models/competicao.dart';
import 'package:flutter_application_1/models/jogador.dart';

class Inscricao {
  Jogador jogador;   
  Competicao competicao; 
  Clube clube;
  int epoca;
  String passaporte;

  Inscricao({
    required this.jogador, 
    required this.competicao, 
    required this.clube,
    required this.epoca, 
    required this.passaporte,
  });

  @override
  String toString() {
    return '${jogador.nomeCamisola} (${clube.sigla})';
  }
}