class Jogador {
  String nomeCompleto;   
  String nomeCamisola; 
  String escolaridade; 
  String nacionalidade;  
  String posicao; 
  DateTime dataNascimento;   
  int peso;   
  int altura;   
  String passaporte;
  DateTime ultimoControloDoping;

  Jogador({
    required this.nomeCompleto, 
    required this.nomeCamisola, 
    required this.escolaridade, 
    required this.nacionalidade,
    required this.posicao,
    required this.dataNascimento,
    required this.peso,
    required this.altura,
    required this.passaporte,
    required this.ultimoControloDoping,
  });

  factory Jogador.fromJson(dynamic json) {
    return Jogador(
      //clubeId: json['clubeId'],
      nomeCompleto: json['nomeCompleto'],
      nomeCamisola: json['nomeCamisola'],
      escolaridade: json['escolaridade'],
      nacionalidade: json['nacionalidade'],
      posicao: json['posicao'],
      dataNascimento: DateTime.parse(json['dataNascimento']),
      peso: json['peso'],
      altura: json['altura'],
      passaporte: json['passaporte'],
      ultimoControloDoping: DateTime.parse(json['ultimoControloDoping']),
    );
  }

  @override
  String toString() {
    return '$posicao - $nomeCamisola';
  }
}