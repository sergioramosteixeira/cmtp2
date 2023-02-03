import 'package:flutter_application_1/models/clube.dart';
import 'package:flutter_application_1/models/jogador.dart';

class Antidoping {
  String clube;   
  Jogador jogador;



  Antidoping({
    required this.clube,
    required this.jogador,
  });

  @override
  String toString() {
    return "${clube} - ${jogador.nomeCamisola}";
  }
}