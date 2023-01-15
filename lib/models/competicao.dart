import 'package:flutter_application_1/data/clubes.dart';

class Competicao {
  String nome;    //nome pelo qual é conhecida
  int divisao; //divisao a nivel nacional  (se for taça divisao = 0)
  int serie;   //para o caso da competição ser dividida por series
  Clubes clubes;

  Competicao({
    required this.nome,
    this.divisao = 0,
    this.serie = 0,
    required this.clubes,
  });

  @override
  String toString() {
    String text = nome;
    if (divisao > 0){
      text += " ($divisaoª Divisão";
      if (serie > 0){
        text += " - Série $serie";
      }
      text += ")";
    } 
    return text;
  }
}