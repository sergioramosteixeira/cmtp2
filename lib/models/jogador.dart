class Jogador {
  String nomeCompleto;   
  String nomeCamisola; 
  int numeroCamisola;  
  String passaporte;
  DateTime ultimoControloDoping;

  Jogador({
    required this.nomeCompleto, 
    required this.nomeCamisola, 
    required this.numeroCamisola, 
    required this.passaporte,
    required this.ultimoControloDoping,
  });

  @override
  String toString() {
    return '$numeroCamisola - $nomeCamisola';
  }
}