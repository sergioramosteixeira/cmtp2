import 'package:flutter_application_1/models/clube.dart';

class Classificacao {
  //Modelo de dados da Classificação

  Clube clube;   
  int golosMarcados;
  int golosSofridos;   
  int vitorias;
  int empates;
  int derrotas;
  int pontos;
  int jogos;
  String grupo;



  Classificacao({
    required this.clube,
    required this.golosMarcados,
    required this.golosSofridos,
    required this.vitorias,
    required this.empates,
    required this.derrotas,
    required this.pontos,
    required this.jogos,
    required this.grupo
  });

  @override
  String toString() {
    return "${clube.sigla} - $pontos";
  }
}