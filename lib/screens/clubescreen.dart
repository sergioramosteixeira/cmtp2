import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/classificacoes.dart';
import 'package:flutter_application_1/data/clubes.dart';
import 'package:flutter_application_1/data/jogadores.dart';
import 'package:flutter_application_1/data/jogos.dart';
import 'package:flutter_application_1/models/clube.dart';
import 'package:flutter_application_1/models/jogador.dart';
import 'package:flutter_application_1/screens/addclube.dart';
import 'package:flutter_application_1/screens/jogadoresinscritos.dart';
import 'package:flutter_application_1/screens/jogadorscreen.dart';
import 'package:flutter_application_1/screens/mainmenu.dart';
import 'package:flutter_application_1/widgets/defaultappbar.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

import 'package:intl/intl.dart';


class ClubeScreen extends StatefulWidget{
  //Screen de mostragem do clube

  static const String routeName = '/clube';  //Rota
  final String clube;                 //Parâmetro obrigatório: Sigla do clube
  ClubeScreen({required this.clube});
  

  @override
  _ClubeScreenState createState() => _ClubeScreenState();
}

class _ClubeScreenState extends State<ClubeScreen> {
  final Clubes _clubes = Clubes();
  final Jogadores _jogadores = Jogadores();
  final Jogos _jogos = Jogos();
  final Classificacoes _classif = Classificacoes();
  List<Jogador> jogadores = [];
  
  Clube? _clube;
  bool admin = false;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");


  //Widget de seleção da data
  Future<DateTime?> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null)
      setState(() {
        controller.text = picked.toString();
      });
    return picked;
  }

  //Widget de Alteração da data de fim de contrato
  showDataTermino(BuildContext context, String passaporte) {
    final dataTermino = TextEditingController();
    
    //Botões de Seleção
    Widget cancelButton = ElevatedButton(
      child: Text("Cancelar"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = ElevatedButton(
      child: Text("Terminar"),
      onPressed:  () {
        Navigator.pop(context);
        _jogadores.terminarContrato(_clube!, passaporte, dataTermino.text);
        setState(() {  
        });
      },
    );

    //Widget de Diálogo de Alerta
    AlertDialog alert = AlertDialog(
      title: Text("Terminar Contrato"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: dataTermino,
            decoration: const InputDecoration(
              labelText: 'Data Término do Contrato',
            ),
            onTap: () => _selectDate(context, dataTermino).then((date) {
              if (date != null) {
                //Formato da data
                dataTermino.text =
                    "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
              }
            }),
          ),
        ],
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    //Abrir o Diálogo de Alerta
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  //Widget de Confirmação de Eliminação de Registo
  showConfirmationBox(BuildContext context) {
    
    //Botões de Seleção
    Widget cancelButton = ElevatedButton(
      child: Text("Cancelar"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = ElevatedButton(
      child: Text("Apagar"),
      onPressed:  () {
        Navigator.pop(context);
        _jogadores.deleteFromClube(_clube!);
        _classif.deleteFromClube(_clube!);
        _jogos.deleteFromClube(_clube!);
        FirebaseFirestore.instance.collection("clubes").doc(_clube!.sigla).delete();
        Navigator.pushReplacementNamed(context, MainMenu.routeName);
      },
    );

    //Widget de Diálogo de Alerta
    AlertDialog alert = AlertDialog(
      title: Text("OPERAÇÃO IRREVERSÍVEL!"),
      content: Text("Tem a certeza que deseja continuar?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

  //Abrir o Diálogo de Alerta 
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  //Calcular a idade a partir da data de nascimento
  int calculateAge(String data) {
    DateTime birthDate = DateTime.parse(data);
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  @override
  void open() {
    //Abrir o menu de admin
    setState(() {
      admin = true;
    });
  }

  @override
  void close() {
    //Fechar o menu de admin
    setState(() {
      admin = false;
    });
  }

  //Atualizar a lista de jogadores
  Future<Jogadores> update() async {
    
    if (_jogadores.list.isEmpty){
      await _jogadores.getJogadores(_clube!);
      jogadores = _jogadores.list;
    } 
    return _jogadores;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(texto: "${widget.clube}"),
      body: SizedBox.expand(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("img/stadium.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                FutureBuilder<List<dynamic>>(
                  future: Future.wait([_clubes.getClubes()]),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      _clube = _clubes.getClubeBySigla(widget.clube);
                      return Column(
                        children: [
                          Container(
                            color: Color.fromARGB(255, 12, 13, 20).withOpacity(0.8),
                            width: double.infinity,
                            margin: const EdgeInsets.all(50),
                            padding: const EdgeInsets.all(10),
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Row(children: [
                                  Text("Clube: ", style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 70, 202, 255)),),
                                  Text(_clube!.nome, style: TextStyle(color: Colors.white))
                                ],),
                                Row(children: [
                                  Text("Sigla: ", style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 70, 202, 255)),),
                                  Text(_clube!.sigla, style: TextStyle(color: Colors.white))
                                ],),
                                Row(children: [
                                  Text("Ano de Fundação: ", style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 70, 202, 255)),),
                                  Text(_clube!.fundado.toString(), style: TextStyle(color: Colors.white))
                                ],),
                                Row(children: [
                                  Text("País: ", style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 70, 202, 255)),),
                                  Text(_clube!.pais, style: TextStyle(color: Colors.white))
                                ],),
                                Row(children: [
                                  Text("Estádio: ", style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 70, 202, 255)),),
                                  Text(_clube!.nomeEstadio, style: TextStyle(color: Colors.white))
                                ],),
                                Row(children: [
                                  Text("Capacidade: ", style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 70, 202, 255)),),
                                  Text(_clube!.capacidadeEstadio.toString(), style: TextStyle(color: Colors.white))
                                ],),
                                Row(children: [
                                  Text("Morada: ", style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 70, 202, 255)),),
                                  Text(_clube!.moradaEstadio, style: TextStyle(color: Colors.white))
                                ],),
                                Row(children: [
                                  Text("Cidade: ", style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 70, 202, 255)),),
                                  Text(_clube!.cidadeEstadio, style: TextStyle(color: Colors.white))
                                ],),
                               ]
                            ),
                          ), 

                          //Lista de Jogadores 
                          FutureBuilder(
                            future: update(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.all(0),
                                  padding: const EdgeInsets.all(10),
                                  alignment: Alignment.center,
                                  child: DataTable(
                                    dataTextStyle: const TextStyle(color: Colors.white, fontFamily: 'Changa'),
                                    headingRowColor: MaterialStateColor.resolveWith((states) {return Color.fromARGB(255, 70, 202, 255).withOpacity(0.8);},),
                                    dataRowColor: MaterialStateColor.resolveWith((states) {return Color.fromARGB(255, 12, 13, 20).withOpacity(0.8);},),
                                    columns: [
                                      const DataColumn(label: Text('Jogador')),
                                      DataColumn(label: Text((admin == false) ? 'País' : 'Ações')),
                                      const DataColumn(label: Text('Posição')),
                                      const DataColumn(label: Text('Idade')),
                                    ],
                                    rows: jogadores
                                        .map((Jogador j) => DataRow(cells: [
                                          DataCell(
                                            InkWell(
                                              child: Text(j.nomeCamisola),
                                              onTap: () => Navigator.pushNamed(context, '${JogadorScreen.routeName}/${j.passaporte}/${j.nomeCamisola}')
                                            ),
                                          ),
                                          DataCell((admin == false) ? 
                                            Text(j.nacionalidade) : 
                                            Row(
                                              children: [
                                                InkWell(
                                                  child: Icon(Icons.delete, color:Color.fromARGB(255, 213, 84, 84)),
                                                  onTap: () {
                                                    _jogadores.deleteFromClube(_clube!, passaporte: j.passaporte);
                                                    setState(() {
                                                      jogadores.remove(j);
                                                    });
                                                  }
                                                ),
                                                Text(" | "),
                                                InkWell(
                                                  child: Icon(Icons.label_important_outlined, color:Color.fromARGB(255, 84, 213, 103)),
                                                  onTap: () {
                                                    showDataTermino(context, j.passaporte);
                                                  }
                                                ),
                                              ],
                                            )
                                          ),
                                          DataCell(Text(j.posicao)),
                                          DataCell(Text(calculateAge(dateFormat.format(j.dataNascimento)).toString())),
                                        ])).toList(),
                                  ),
                                );
                              } else if (snapshot.hasError) {
                                return Text("${snapshot.error}");
                              }
                              return CircularProgressIndicator();
                            },
                          ),
                                
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return CircularProgressIndicator();
                  },
                ),
                
                
                const Text(
                  "Desenvolvido por Lara Figueiredo e Sérgio Teixeira", style: TextStyle(color: Colors.white)),
                const Text("Computação Móvel - ISPGAYA - 2023", style: TextStyle(color: Colors.yellow)),
                
              ]
            ),
          )
        ),
      ),

      //MENU ADMIN em Floating Action Buttons
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        onOpen: open,
        onClose: close,
        backgroundColor: Color.fromARGB(255, 12, 0, 62),
        children: [
          FloatingActionButton.small(
            heroTag: "EditClube",
            backgroundColor: Color.fromARGB(255, 12, 0, 62),
            child: const Icon(Icons.edit),
            onPressed: () {
              Navigator.pushNamed(context, AddClube.routeName+"/"+_clube!.sigla);
            },
          ),
          FloatingActionButton.small(
            heroTag: "DeleteClube",
            backgroundColor: Color.fromARGB(255, 140, 0, 0),
            child: const Icon(Icons.delete),
            onPressed: () {
              showConfirmationBox(context);
            },
          ),
          FloatingActionButton.small(
            heroTag: "AddJogador",
            backgroundColor: Color.fromARGB(255, 12, 0, 62),
            child: const Icon(Icons.person_add),
            onPressed: () {
              Navigator.pushNamed(context, JogadoresInscritos.routeName+"/clube/"+_clube!.sigla);
            },
          ),
          
        ],
      ), 
    );
  }
}

