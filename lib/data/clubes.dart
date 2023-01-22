import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/clube.dart';

class Clubes {
  List<Clube> _clubes = [];

  List<Clube> get allClubes => [..._clubes];


  final CollectionReference _collectionRef =FirebaseFirestore.instance.collection('clubes');

  Future<List<Clube>> getClubes() async {

      QuerySnapshot querySnapshot = await _collectionRef.get();


      querySnapshot.docs.map((doc) => doc.data()).toList().forEach((clube) {
        _clubes.add(Clube.fromJson(clube));
      });

      return _clubes;
  }

  Clube getClubeBySigla(String sigla) {
    return allClubes.firstWhere((Clube c) => c.sigla == sigla);
  }

  List<Clube> get list => _clubes.toList();

}