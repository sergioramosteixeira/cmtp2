import 'package:flutter_application_1/models/clube.dart';

class Jogo {
  int jornada;
  Clube visitado;
  Clube visitante;
  int golosCasa;
  int golosFora;
  DateTime dataHora;

  Jogo({
    required this.jornada, 
    required this.visitado, 
    required this.visitante, 
    required this.golosCasa,
    required this.golosFora,
    required this.dataHora,
  });

  @override
  String toString() {
    return '$dataHora | ${visitado.sigla} $golosCasa-$golosFora ${visitante.sigla}';
  }
}