
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/data/clubes.dart';
import 'package:flutter_application_1/models/antidoping.dart';
import 'package:flutter_application_1/models/clube.dart';
import 'package:flutter_application_1/models/contrato.dart';
import 'package:flutter_application_1/models/jogador.dart';
import 'package:flutter_application_1/models/jogo.dart';
import 'package:image/image.dart';

import 'package:intl/intl.dart';

class Antidopings {
  List<Antidoping> _antidoping = [];
  List<Antidoping> get allAntidoping => [..._antidoping];

  DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  final CollectionReference _collectionClubes =FirebaseFirestore.instance.collection('clubeJogadores');
  final CollectionReference _collectionJogadores=FirebaseFirestore.instance.collection('jogadores');

  Future<List<Antidoping>> processClube(Jogador jogador) async {
    QuerySnapshot querySnapshot = await _collectionClubes.where('passaporte', isEqualTo: jogador.passaporte).where('fimContrato', isGreaterThanOrEqualTo: dateFormat.format(DateTime.now())).get();
    querySnapshot.docs.map((doc) => doc.data()).toList().forEach((clube) {
      dynamic c = clube;
      _antidoping.add(Antidoping(jogador: jogador, clube: c["clube"] ));
      
      
    });
    return _antidoping;
  }


  Future<List<Antidoping>> getJogadores(int dias) async {
    List<Future> futures = [];
    _antidoping = [];
    DateTime date = DateTime.now();
    QuerySnapshot querySnapshot = await _collectionJogadores.where('ultimoControloDoping', isGreaterThanOrEqualTo: dateFormat.format(DateTime(date.year, date.month, date.day - dias))).get();

    querySnapshot.docs.map((doc) => doc.data()).toList().forEach((jogador) async {
      futures.add(processClube(Jogador.fromJson(jogador)));
        
          
    });
    await Future.wait(futures);
    _antidoping.sort((a, b) => a.jogador.ultimoControloDoping.compareTo(b.jogador.ultimoControloDoping));
    return _antidoping;
  }


  

  List<Antidoping> get list => _antidoping.toList();
}