
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


   Future<void> deleteJogador(String passaporte, {String? clube}) async {
    final WriteBatch batch = FirebaseFirestore.instance.batch();
    QuerySnapshot querySnapshot;
    // Buscar todos os documentos que atendem aos critérios da cláusula WHERE.
    (clube != null) ? 
      querySnapshot = await _collectionClubes.where("clube", isEqualTo: clube).where("passaporte", isEqualTo: passaporte).get() :
      querySnapshot = await _collectionClubes.where("passaporte", isEqualTo: passaporte).get();

    // Adicionar todos os documentos encontrados ao objeto WriteBatch.
    querySnapshot.docs.forEach((DocumentSnapshot document) {
      batch.delete(document.reference);
    });

    // Executar a exclusão em lote.
    await batch.commit();
  }
  

  List<Contrato> get list => _historico.toList();
}