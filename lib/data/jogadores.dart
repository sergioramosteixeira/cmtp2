
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/data/clubes.dart';
import 'package:flutter_application_1/models/clube.dart';
import 'package:flutter_application_1/models/contrato.dart';
import 'package:flutter_application_1/models/jogador.dart';
import 'package:flutter_application_1/models/jogo.dart';

import 'package:intl/intl.dart';

class Jogadores {
  List<Jogador> _jogadores = [];
  List<Jogador> get allJogadores => [..._jogadores];

  DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  final CollectionReference _collectionClubes =FirebaseFirestore.instance.collection('clubeJogadores');
  final CollectionReference _collectionJogadores=FirebaseFirestore.instance.collection('jogadores');

  Future<List<Jogador>> getJogadores(Clube clube) async {
      _jogadores = [];
      QuerySnapshot querySnapshot = await _collectionClubes.where('clube', isEqualTo: clube.sigla).where('fimContrato', isGreaterThanOrEqualTo: dateFormat.format(DateTime.now())).get();

      querySnapshot.docs.map((doc) => doc.data()).toList().forEach((clube) async {
        dynamic c = clube;
        QuerySnapshot queryFora = await _collectionJogadores.where('passaporte', isEqualTo: c["passaporte"]).get();
        queryFora.docs.map((doc) => doc.data()).toList().forEach((jogador) {
          dynamic j = jogador;
          
          _jogadores.add(Jogador.fromJson(jogador));
          _jogadores.sort((a, b) {
            final posicoes = ['Guarda-Redes', 'Defesa', 'Médio', 'Avançado'];
            final indexA = posicoes.indexOf(a.posicao);
            final indexB = posicoes.indexOf(b.posicao);

            if (indexA != indexB) {
              return indexA.compareTo(indexB);
            } else {
              return a.nomeCamisola.compareTo(b.nomeCamisola);
            }
          });
          
      });
    });
    return Future.delayed(Duration(seconds: 1), () => _jogadores);
  }

  Future<void> deleteFromClube(Clube clube, {String? passaporte}) async {
    final WriteBatch batch = FirebaseFirestore.instance.batch();
    QuerySnapshot querySnapshot;
    // Buscar todos os documentos que atendem aos critérios da cláusula WHERE.
    (passaporte != null) ? 
      querySnapshot = await _collectionClubes.where("clube", isEqualTo: clube.sigla).where("passaporte", isEqualTo: passaporte).get() :
      querySnapshot = await _collectionClubes.where("clube", isEqualTo: clube.sigla).get();

    // Adicionar todos os documentos encontrados ao objeto WriteBatch.
    querySnapshot.docs.forEach((DocumentSnapshot document) {
      batch.delete(document.reference);
    });

    // Executar a exclusão em lote.
    await batch.commit();
  }

  Future<void> terminarContrato(Clube clube, String passaporte, String novaData) async {
    final WriteBatch batch = FirebaseFirestore.instance.batch();
    QuerySnapshot querySnapshot;
    // Buscar todos os documentos que atendem aos critérios da cláusula WHERE.
    querySnapshot = await _collectionClubes.where("clube", isEqualTo: clube.sigla).where("passaporte", isEqualTo: passaporte).get();
    // Adicionar todos os documentos encontrados ao objeto WriteBatch.
    querySnapshot.docs.forEach((DocumentSnapshot document) {
      _collectionClubes.doc(document.id).update({"fimContrato": novaData});
    });

  }
  

  List<Jogador> get list => _jogadores.toList();
}