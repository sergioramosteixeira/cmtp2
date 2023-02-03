class Clube {
  //Modelo de dados do Clube

  String nome;
  String sigla;
  String logo;
  String pais;
  int fundado;
  String nomeEstadio;
  String moradaEstadio;
  String cidadeEstadio;
  int capacidadeEstadio;

  Clube({

      required this.nome,
      required this.sigla,
      required this.logo,
      required this.pais,
      required this.fundado,
      required this.nomeEstadio,
      required this.moradaEstadio,
      required this.cidadeEstadio,
      required this.capacidadeEstadio});

  //Método de conversão a partir de JSON (Firestore) para a classe
  factory Clube.fromJson(dynamic json) {
    return Clube(
      nome: json['nome'],
      sigla: json['sigla'],
      logo: json['logo'],
      pais: json['pais'],
      fundado: json['fundado'],
      nomeEstadio: json['nomeEstadio'],
      moradaEstadio: json['moradaEstadio'],
      cidadeEstadio: json['cidadeEstadio'],
      capacidadeEstadio: json['capacidadeEstadio'],
    );
  }


  @override
  String toString() {
    return sigla;
  }
}
