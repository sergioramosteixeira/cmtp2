class Clube {
  String nome;   
  String sigla; 
  String pais;       //o país serve para registar transferencias estrangeiras. Para campeonatos nacionais apenas serao validos clubes pt
  String localidade;

  Clube({
    required this.nome, 
    required this.sigla, 
    required this.pais, 
    required this.localidade,
  });

  @override
  String toString() {
    return nome;
  }
}