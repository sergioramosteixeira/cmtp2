import 'package:flutter_application_1/models/clube.dart';

class Classificacao {
  Clube clube;   
  int golosMarcados;
  int golosSofridos;   
  int vitorias;
  int empates;
  int derrotas;
  int pontos;
  int jogos;



  Classificacao({
    required this.clube,
    required this.golosMarcados,
    required this.golosSofridos,
    required this.vitorias,
    required this.empates,
    required this.derrotas,
    required this.pontos,
    required this.jogos
  });

  @override
  String toString() {
    return "${clube.sigla} - $pontos";
  }
}