
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/data/clubes.dart';
import 'package:flutter_application_1/models/clube.dart';
import 'package:flutter_application_1/models/contrato.dart';
import 'package:flutter_application_1/models/jogador.dart';
import 'package:flutter_application_1/models/jogo.dart';

import 'package:intl/intl.dart';

class Contratos {

  List<Contrato> _contratos = [];
  List<Contrato> get allContratos => [..._contratos];

  DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  final CollectionReference _collectionClubes =FirebaseFirestore.instance.collection('clubeJogadores');
  final CollectionReference _collectionJogadores=FirebaseFirestore.instance.collection('jogadores');

  Future<List<Contrato>> getContratos(Clube clube) async {
      _contratos = [];
      QuerySnapshot querySnapshot = await _collectionClubes.where('clube', isEqualTo: clube.sigla).where('fimContrato', isGreaterThanOrEqualTo: dateFormat.format(DateTime.now())).get();

      querySnapshot.docs.map((doc) => doc.data()).toList().forEach((clube) async {
        dynamic c = clube;
        QuerySnapshot queryFora = await _collectionJogadores.where('passaporte', isEqualTo: c["passaporte"]).get();
        queryFora.docs.map((doc) => doc.data()).toList().forEach((jogador) {
          dynamic j = jogador;
          
          _contratos.add(Contrato(jogador: j["nomeCamisola"], clube: c["clube"], inicioContrato: DateTime.parse(c["inicioContrato"]), fimContrato: DateTime.parse(c["fimContrato"]), numeroCamisola: int.parse(c["numeroCamisola"])));
          _contratos.sort((a, b) => a.inicioContrato.compareTo(b.inicioContrato));
          
      });
    });
    return Future.delayed(Duration(milliseconds: 500), () => _contratos);
  }

  

  List<Contrato> get list => _contratos.toList();
}