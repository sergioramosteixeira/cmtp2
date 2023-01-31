
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/data/clubes.dart';
import 'package:flutter_application_1/models/clube.dart';
import 'package:flutter_application_1/models/contrato.dart';
import 'package:flutter_application_1/models/jogador.dart';
import 'package:flutter_application_1/models/jogo.dart';

import 'package:intl/intl.dart';

class HistoricoJogador {
  List<Contrato> _historico = [];
  List<Contrato> get allHistorico => [..._historico];
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  final Clubes _clubes = Clubes();

  final CollectionReference _collectionClubes =FirebaseFirestore.instance.collection('clubeJogadores');

  Future<List<Contrato>> getHistorico(String passaporte) async {
    _historico = [];
    QuerySnapshot querySnapshot = await _collectionClubes.where('passaporte', isEqualTo: passaporte).get();

    querySnapshot.docs.map((doc) => doc.data()).toList().forEach((clube) async {
      dynamic c = clube;
        _historico.add(Contrato(jogador: passaporte, clube: c["clube"], inicioContrato: DateTime.parse(c["inicioContrato"]), fimContrato: DateTime.parse(c["fimContrato"]), numeroCamisola: int.parse(c["numeroCamisola"])));

        _historico.sort((a, b) => b.fimContrato.compareTo(a.fimContrato));
          
        
    });
    
    return Future.delayed(Duration(milliseconds: 500), () => _historico);
  }

  

  List<Contrato> get list => _historico.toList();
}