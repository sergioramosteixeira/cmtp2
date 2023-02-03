import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/data/clubes.dart';
import 'package:flutter_application_1/models/classificacao.dart';
import 'package:flutter_application_1/models/clube.dart';

class Classificacoes {
  //Classe de dados para as Classificações

  List<Classificacao> _classif = [];
  List<Classificacao> get allClassif => [..._classif];

  final CollectionReference _collectionClubes =FirebaseFirestore.instance.collection('clubesLiga');
  final CollectionReference _collectionJogos =FirebaseFirestore.instance.collection('jogos');

  //Pesquisar no FireStore todos os jogos de um clube até uma determinada jornada a calcular os seus pontos e golos
  Future<List<Classificacao>> processClube(Clubes clubes, String liga, int jornada, String sigla, dynamic grupo) async {

    //Pesquisar os Jogos em Casa
    QuerySnapshot queryCasa = await _collectionJogos.where('liga', isEqualTo: liga).where('jornada', isLessThanOrEqualTo: jornada).where('clubeCasa', isEqualTo: sigla).get();
      int vitorias = 0;
      int empates = 0;
      int derrotas = 0;
      int golosMarcados = 0;
      int golosSofridos = 0;
      int jogos = 0;
      int pontos = 0;
      queryCasa.docs.map((doc) => doc.data()).toList().forEach((jogo) {
        dynamic j = jogo;
        jogos++;
        golosMarcados += int.parse(j["golosCasa"].toString());
        golosSofridos += int.parse(j["golosFora"].toString());
        if(int.parse(j["golosCasa"].toString()) > int.parse(j["golosFora"].toString())){
          vitorias++;
          pontos+=3;
        }else{
          if(int.parse(j["golosCasa"].toString()) == int.parse(j["golosFora"].toString())){
            empates++;
            pontos+=1;
          }else {
            derrotas++;
          }
        }
      });

      //Pesquisar os Jogos Fora
      QuerySnapshot queryFora = await _collectionJogos.where('liga', isEqualTo: liga).where('jornada', isLessThanOrEqualTo: jornada).where('clubeFora', isEqualTo: sigla).get();

      queryFora.docs.map((doc) => doc.data()).toList().forEach((jogo) {
        dynamic j = jogo;
        jogos++;
        golosMarcados += int.parse(j["golosFora"].toString());
        golosSofridos += int.parse(j["golosCasa"].toString());
        if(int.parse(j["golosFora"].toString()) > int.parse(j["golosCasa"].toString())){
          vitorias++;
          pontos+=3;
        }else{
          if(int.parse(j["golosCasa"].toString()) == int.parse(j["golosFora"].toString())){
            empates++;
            pontos+=1;
          }else {
            derrotas++;
          }
        }
      });
      _classif.add(Classificacao(clube: clubes.getClubeBySigla(sigla), derrotas: derrotas, empates: empates, golosMarcados: golosMarcados, golosSofridos: golosSofridos, pontos: pontos, vitorias: vitorias, jogos: jogos, grupo: "$grupo"));
      return _classif;
  }

  //Pesquisar no FireStore todos os clubes pertencentes numa determinada liga
  Future<List<Classificacao>> getClassificacao(Clubes clubes, String liga, int jornada) async {
    _classif = [];
    List<Future> futures = [];
    QuerySnapshot querySnapshot = await _collectionClubes.where('liga', isEqualTo: liga).get();
    if (jornada>90) jornada = 34;

    querySnapshot.docs.map((doc) => doc.data()).toList().forEach((clube) async {
      dynamic c = clube;
      futures.add(processClube(clubes, liga, jornada, c['clube'], "${c['grupo']}"));
    });


    await Future.wait(futures); //Esperar pelos resultados do FireStore

    //Ordenar a tabela por grupos, pontos e golos marcados.
    _classif.sort((a, b) {
      if (a.grupo != b.grupo) {
        return a.grupo.compareTo(b.grupo);
      } else if (a.pontos != b.pontos) {
        return b.pontos - a.pontos;
      } else {
        return b.golosMarcados - a.golosMarcados;
      }
    });
    return  _classif;
  }


  //Método para apagar um clube de uma determinada Liga (ou todas, caso o parâmetro liga não seja assumido)
  Future<void> deleteFromClube(Clube clube, {String? liga}) async {
    final WriteBatch batch = FirebaseFirestore.instance.batch();

    //Pesquisar todos os registos
    final QuerySnapshot querySnapshot;
    (liga == null) ?
      querySnapshot = await _collectionClubes
        .where("clube", isEqualTo: clube.sigla)
        .get() :
      querySnapshot = await _collectionClubes
        .where("clube", isEqualTo: clube.sigla)
        .where("liga", isEqualTo: liga)
        .get();

    // Adicionar todos os documentos encontrados ao objeto WriteBatch.
    querySnapshot.docs.forEach((DocumentSnapshot document) {
      batch.delete(document.reference);
    });

    // Executar a exclusão em lote.
    await batch.commit();
  }

  List<Classificacao> get list => _classif.toList();
}
