import 'package:flutter_application_1/models/clube.dart';

class Jogo {
  //Modelo de dados do Jogo
  String liga;
  DateTime dataJogo;
  int jornada;
  String estadio;
  String arbitro;
  Clube clubeCasa;
  Clube clubeFora;
  int golosCasa;
  int golosFora;

  Jogo({
    required this.liga,
    required this.dataJogo,
    required this.jornada,
    required this.estadio,
    required this.arbitro,
    required this.clubeCasa,
    required this.clubeFora,
    required this.golosCasa,
    required this.golosFora
  });


  //Método de conversão a partir de JSON (Firestore) para a classe
  factory Jogo.fromJson(dynamic json, Clube casa, Clube fora)  {
    return Jogo(
      liga: json['liga'],
      dataJogo: DateTime.parse(json['dataJogo']),
      jornada: json['jornada'],
      estadio: json['estadio'],
      arbitro: json['arbitro'],
      clubeCasa: casa,
      clubeFora: fora,
      golosCasa: json['golosCasa'],
      golosFora: json['golosFora'],
    );
  }

  @override
  String toString() {
    return "${clubeCasa.sigla} - ${clubeFora.sigla}";
  }
}