class Contrato {
  //Modelo de dados de Contratos

  String jogador;   
  String clube; 
  DateTime inicioContrato;
  DateTime fimContrato;
  int numeroCamisola;

  Contrato({
    required this.jogador, 
    required this.clube, 
    required this.inicioContrato, 
    required this.fimContrato,
    required this.numeroCamisola,
  });

  @override
  String toString() {
    return '${numeroCamisola} (${clube})';
  }
}