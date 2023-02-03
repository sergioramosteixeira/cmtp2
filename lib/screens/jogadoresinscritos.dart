import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/models/clube.dart';
import 'package:flutter_application_1/models/jogador.dart';
import 'package:flutter_application_1/screens/adminscreen.dart';
import 'package:flutter_application_1/screens/clubescreen.dart';
import 'package:flutter_application_1/screens/jogadorscreen.dart';
import 'package:flutter_application_1/widgets/defaultappbar.dart';
import 'package:intl/intl.dart';

class JogadoresInscritos extends StatefulWidget{
  //Screen de associação de jogadores em clubes

  static final String routeName = '/jogadoresinscritos';  //Rota
  String? clube;            //Se o parâmetro clube não for nulo, o clube é preenchido automático
  String? passaporte;       //Se o parâmetro passaporte não for nulo, o jogador é preenchido automático
  JogadoresInscritos({this.clube, this.passaporte});

  @override
  State<JogadoresInscritos> createState() => _JogadoresInscritosState();
}

  
class _JogadoresInscritosState extends State<JogadoresInscritos> {
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  final inicioContrato = TextEditingController();
  final fimContrato = TextEditingController();
  final numeroCamisola = TextEditingController(); 

  Clube _clube = Clube(capacidadeEstadio: 0, fundado: 0, cidadeEstadio: '', logo: '', moradaEstadio: '', nome: '', nomeEstadio: '', pais: '', sigla: '');
  Jogador _jogador = Jogador(altura: 0, dataNascimento: DateTime(2023), escolaridade: '', nacionalidade: '', nomeCamisola: '', nomeCompleto: '', passaporte: '', peso: 0, posicao: '', ultimoControloDoping: DateTime(2023));
  List<DropdownMenuItem<Clube>> _options = [];
  List<DropdownMenuItem<Jogador>> _optionsJogadores = [];
  List<String> clubejogadores = [];
  final _firestore = FirebaseFirestore.instance;

  //Widget da seleção de data
  Future<DateTime?> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = picked.toString();
      });
    }
    return picked;
  }

  @override
  void initState() {
    super.initState();
    _options = [];
    //Se o parâmetro passaporte for nulo, são listados todos os jogadores livres
    if (widget.passaporte == null) {
      _firestore.collection("clubeJogadores").where('fimContrato', isGreaterThanOrEqualTo: dateFormat.format(DateTime.now())).get().then((snapshot) {
        snapshot.docs.forEach((document) {
          clubejogadores.add(document["passaporte"]);
        });
      });
      _firestore.collection("jogadores").get().then((snapshot) {
        snapshot.docs.forEach((document) {
          if (!clubejogadores.contains(document["passaporte"])){
            _optionsJogadores.add(
              DropdownMenuItem(
                child: Text(document["passaporte"]+"-"+document["nomeCamisola"]),
                value: Jogador.fromJson(document),
              ),
            );
          }
        });
        if (_optionsJogadores.isNotEmpty) {
          _jogador = _optionsJogadores[0].value!;
        }
      });
    //Se o parâmetro passaporte não for nulo, o jogador é preenchido automático
    } else {
      _firestore.collection("jogadores").where("passaporte", isEqualTo: widget.passaporte).get().then((snapshot) {
        snapshot.docs.forEach((document) {
          _optionsJogadores.add(
            DropdownMenuItem(
              child: Text(document["passaporte"]+"-"+document["nomeCamisola"]),
              value: Jogador.fromJson(document),
            ),
          );
        });
        if (_optionsJogadores.isNotEmpty) {
          _jogador = _optionsJogadores[0].value!;
        }
      });
    }
    //São listados todos os clubes portugueses e não portugueses
    _firestore.collection("clubes").get().then((snapshot) {
      snapshot.docs.forEach((document) {
        _options.add(
          DropdownMenuItem(
            child: Text(document["sigla"]),
            value: Clube.fromJson(document),
          ),
        );
      });
      if (_options.isNotEmpty) {
        //Se o parâmetro clube não for nulo, o clube é preenchido automático
        (widget.clube != null) ? _clube = _options.firstWhere((element) => element.value!.sigla == widget.clube).value! : _clube = _options[0].value!;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(logo: "lp"),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15), 
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: DropdownButton<Jogador>(
                    isExpanded: true,
                    value: _jogador,
                    items: _optionsJogadores,
                    onChanged: (value) {
                      setState(() {
                        _jogador = value!;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: DropdownButton<Clube>(
                    isExpanded: true,
                    value: _clube,
                    items: _options,
                    onChanged: (value) {
                      setState(() {
                        _clube = value!;
                      });
                    },
                  ),
                ),
              ),
              TextField(
                controller: inicioContrato,
                decoration: const InputDecoration(
                  labelText: "Início de Contrato",
                ),
                keyboardType: TextInputType.datetime,
                onTap: () => _selectDate(context, inicioContrato).then((date) {
                  if (date != null) {
                    //Formato da data
                    inicioContrato.text = "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
                  }
                }),
              ),
              TextField(
                controller: fimContrato,
                decoration: const InputDecoration(
                  labelText: "Fim de Contrato",
                ),
                keyboardType: TextInputType.datetime,
                onTap: () => _selectDate(context, fimContrato).then((date) {
                  if (date != null) {
                    //Formato da data
                    fimContrato.text = "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
                  }
                }),
              ),
              TextField(
                controller: numeroCamisola,
                decoration: const InputDecoration(
                  labelText: "Número da Camisola",
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
             
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {

                      //Inserção do registo no Firestore
                      FirebaseFirestore.instance
                        .collection("clubeJogadores")
                        .doc("${_jogador.passaporte}_${_clube.sigla}_${inicioContrato.text}")
                        .set({
                          "passaporte": _jogador.passaporte,
                          "clube": _clube.sigla,
                          "inicioContrato": inicioContrato.text,
                          "fimContrato": fimContrato.text,
                          "numeroCamisola": numeroCamisola.text,
                        });

                      //Se o clube e o passaporte não tiverem sido mencionados, vai para a página do menu admin
                      //Se o clube tiver sido mencionada, vai para a página desse clube
                      //Se o passaporte tiver sido mencionado, vai para a página desse jogador
                      (widget.clube == null && widget.passaporte == null) ? 
                        Navigator.popUntil(context, ModalRoute.withName(AdminScreen.routeName)) : 
                        null;
                      (widget.clube != null) ? 
                        Navigator.pushReplacementNamed(context, ClubeScreen.routeName+"/"+widget.clube!) :
                        null;
                      (widget.passaporte != null) ? 
                        Navigator.pushReplacementNamed(context, JogadorScreen.routeName+"/"+widget.passaporte!+"/"+_jogador.nomeCamisola) :
                        null;
                      
                    },
                    //Estilo do botão de confirmação
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, 
                      backgroundColor: Colors.green.withOpacity(0.5), 
                      padding: const EdgeInsets.all(15), 
                      disabledForegroundColor: Colors.lightGreen.withOpacity(0.38), 
                      disabledBackgroundColor: Colors.lightGreen.withOpacity(0.12),
                      shadowColor: Colors.green,
                      textStyle: const TextStyle(
                        fontSize: 24,
                        fontFamily: 'Changa',
                      )
                    ), 
                    child: const Text(
                     'Inscrever Jogador',
                    ),
                  ),

                  //Botão de cancelar
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AdminScreen.routeName);
                      AdminScreen(); 
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, 
                      backgroundColor: Colors.red.withOpacity(0.5), 
                      padding: const EdgeInsets.all(15), 
                      disabledForegroundColor: Colors.lightGreen.withOpacity(0.38), 
                      disabledBackgroundColor: Colors.lightGreen.withOpacity(0.12),
                      shadowColor: Colors.green,
                      textStyle: const TextStyle(
                        fontSize: 24,
                        fontFamily: 'Changa',
                      )
                    ), 
                    child: const Text(
                     'Não Inscrever',
                    ),
                  ),
                ],
              ),
            ]
          )
        ),
      )
    );
  }
}