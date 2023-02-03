
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

  Future<void> deleteFromClube(Clube clube, {Clube? clubeFora, String? liga}) async {
    final WriteBatch batch = FirebaseFirestore.instance.batch();

    if (liga==null && clubeFora==null)
    {
      final QuerySnapshot querySnapshot = await _collectionRef
          .where("clubeCasa", isEqualTo: clube.sigla)
          .get();

      // Adicionar todos os documentos encontrados ao objeto WriteBatch.
      querySnapshot.docs.forEach((DocumentSnapshot document) {
        batch.delete(document.reference);
      });

      final QuerySnapshot querySnapshot2 = await _collectionRef
          .where("clubeFora", isEqualTo: clube.sigla)
          .get();

      // Adicionar todos os documentos encontrados ao objeto WriteBatch.
      querySnapshot2.docs.forEach((DocumentSnapshot document) {
        batch.delete(document.reference);
      });
    } else {
      final QuerySnapshot querySnapshot = await _collectionRef
            .where("clubeCasa", isEqualTo: clube.sigla)
            .where("clubeFora", isEqualTo: clubeFora!.sigla)
            .where("liga", isEqualTo: liga)
            .get();
      
      querySnapshot.docs.forEach((DocumentSnapshot document) {
        batch.delete(document.reference);
      });
    }

    // Executar a exclusão em lote.
    await batch.commit();
  }

  Future<void> updateResultado(String liga, String clubeCasa, String clubeFora, int golosCasa, int golosFora) async {
    final WriteBatch batch = FirebaseFirestore.instance.batch();

    
    final QuerySnapshot querySnapshot = await _collectionRef
          .where("clubeCasa", isEqualTo: clubeCasa)
          .where("clubeFora", isEqualTo: clubeFora)
          .where("liga", isEqualTo: liga)
          .get();
    
    querySnapshot.docs.forEach((DocumentSnapshot document) {
      _collectionRef.doc(document.id).update({"golosCasa": golosCasa, "golosFora": golosFora});
    });

  }

  List<Jogo> get list => _jogos.toList();
}