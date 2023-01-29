
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/data/clubes.dart';
import 'package:flutter_application_1/models/classificacao.dart';
import 'package:flutter_application_1/models/clube.dart';
import 'package:flutter_application_1/models/jogo.dart';

class Jogos {
  List<Jogo> _jogos = [];
  List<Jogo> get allJogos => [..._jogos];

  final CollectionReference _collectionRef =FirebaseFirestore.instance.collection('jogos');

  Future<List<Jogo>> getJogos(Clubes clubes, String liga, int jornada) async {
      _jogos = [];
      QuerySnapshot querySnapshot = await _collectionRef.where('liga', isEqualTo: liga).where('jornada', isEqualTo: jornada).get();
      Clube casa;
      Clube fora;

      querySnapshot.docs.map((doc) => doc.data()).toList().forEach((jogo) {
        dynamic j = jogo;
        casa = clubes.getClubeBySigla(j['clubeCasa']);
        fora = clubes.getClubeBySigla(j['clubeFora']);
        _jogos.add(Jogo.fromJson(jogo, casa, fora));
      });
      return _jogos;
  }

  

  List<Jogo> get list => _jogos.toList();
}