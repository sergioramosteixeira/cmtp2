import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/data/clubes.dart';
import 'package:flutter_application_1/models/contrato.dart';
import 'package:intl/intl.dart';

class HistoricoJogador {
  //Classe de dados para o Histórico de um Jogador

  List<Contrato> _historico = [];
  List<Contrato> get allHistorico => [..._historico];
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  final CollectionReference _collectionClubes =FirebaseFirestore.instance.collection('clubeJogadores');


  //Pesquisar no FireStore os clubes onde um determinado número de passaporte teve registado
  Future<List<Contrato>> getHistorico(String passaporte) async {
    _historico = [];
    QuerySnapshot querySnapshot = await _collectionClubes.where('passaporte', isEqualTo: passaporte).get();

    querySnapshot.docs.map((doc) => doc.data()).toList().forEach((clube) {
      dynamic c = clube;
        _historico.add(Contrato(jogador: passaporte, clube: c["clube"], inicioContrato: DateTime.parse(c["inicioContrato"]), fimContrato: DateTime.parse(c["fimContrato"]), numeroCamisola: int.parse(c["numeroCamisola"])));
        _historico.sort((a, b) => b.fimContrato.compareTo(a.fimContrato));  
    });
    
    return  _historico;
  }

  //Apagar o jogador de um determinado clube (ou de todos os clubes, caso o parâmetro "clube" seja nulo)
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