
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

  Future<List<Contrato>> processJogador(String passaporte, String clube, String inicioContrato, String fimContrato, String numeroCamisola) async {
    QuerySnapshot queryFora = await _collectionJogadores.where('passaporte', isEqualTo: passaporte).get();
    queryFora.docs.map((doc) => doc.data()).toList().forEach((jogador) {
      dynamic j = jogador;
      
      _contratos.add(Contrato(jogador: j["nomeCamisola"], clube: clube, inicioContrato: DateTime.parse(inicioContrato), fimContrato: DateTime.parse(fimContrato), numeroCamisola: int.parse(numeroCamisola)));

      
    });
    return _contratos;
  }


  Future<List<Contrato>> getContratos(Clube clube, String tipo) async {
    List<Future> futures = [];
    if(tipo == "longevidade"){
      _contratos = [];
      QuerySnapshot querySnapshot = await _collectionClubes.where('clube', isEqualTo: clube.sigla).where('fimContrato', isGreaterThanOrEqualTo: dateFormat.format(DateTime.now())).get();

      querySnapshot.docs.map((doc) => doc.data()).toList().forEach((clube) async {
        dynamic c = clube;
        futures.add(processJogador(c["passaporte"], c["clube"], c["inicioContrato"], c["fimContrato"], c["numeroCamisola"]));
      });
      
      await Future.wait(futures);
      _contratos.sort((a, b) => a.inicioContrato.compareTo(b.inicioContrato));
    }
    if(tipo == "a expirar"){
      _contratos = [];
      DateTime date=DateTime.now();
      QuerySnapshot querySnapshot = await _collectionClubes.where('clube', isEqualTo: clube.sigla).where('fimContrato', isGreaterThanOrEqualTo: dateFormat.format(date)).where('fimContrato', isLessThanOrEqualTo: dateFormat.format(DateTime(date.year, date.month + 6, date.day))).get();

      querySnapshot.docs.map((doc) => doc.data()).toList().forEach((clube) async {
        dynamic c = clube;
        futures.add(processJogador(c["passaporte"], c["clube"], c["inicioContrato"], c["fimContrato"], c["numeroCamisola"]));
      });
      
      await Future.wait(futures);
      _contratos.sort((a, b) => a.fimContrato.compareTo(b.fimContrato));
    }
     
      
    return _contratos;
  }

  

  List<Contrato> get list => _contratos.toList();
}