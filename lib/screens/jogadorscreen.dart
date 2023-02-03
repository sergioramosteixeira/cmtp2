import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/historicojogador.dart';
import 'package:flutter_application_1/models/contrato.dart';
import 'package:flutter_application_1/models/jogador.dart';
import 'package:flutter_application_1/screens/addjogador.dart';
import 'package:flutter_application_1/screens/jogadoresinscritos.dart';
import 'package:flutter_application_1/screens/mainmenu.dart';
import 'package:flutter_application_1/widgets/defaultappbar.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

import 'package:intl/intl.dart';
import 'clubescreen.dart';


class JogadorScreen extends StatefulWidget{
  //Screen de mostragem do jogador

  static const String routeName = '/jogador'; //Rota
  final String passaporte;    //Parâmetro obrigatório: passaporte
  final String jogador;       //Parâmetro obrigatório: nome do Jogador
  JogadorScreen({required this.passaporte, required this.jogador});
  

  @override
  _JogadorScreenState createState() => _JogadorScreenState();
}

class _JogadorScreenState extends State<JogadorScreen> {
  
  List<int> _jornadas = [];
  final HistoricoJogador _historico = HistoricoJogador();
  List<Contrato> historico = [];
  Jogador _jogador = Jogador(nomeCompleto: "a", nomeCamisola: "a", escolaridade: "a", nacionalidade: "a", posicao: "a", dataNascimento: DateTime(2000,1,1), peso: 0, altura: 0, passaporte: 'a', ultimoControloDoping: DateTime(2000,1,1));

  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  final _firestore = FirebaseFirestore.instance;

  List<Widget> infopessoal = [ ];
  bool admin = false;

  @override
  void initState() {
    super.initState();
    fetchData();
    
    setState(() {
      
    });
  }

  @override
  void fetchData() {
    //Buscar os dados pessoais do jogador no Firestore e preencher na janela correspondente
    _firestore.collection("jogadores").where("passaporte", isEqualTo: widget.passaporte).get().then((snapshot) {
      snapshot.docs.forEach((document) {
        _jogador=Jogador.fromJson(document);
      });

      setState(() {
        infopessoal = [ 
          Row(children: [
            Text("Nome Completo: ", style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 70, 202, 255)),),
            Text(_jogador.nomeCompleto, style: TextStyle(color: Colors.white))
          ],),
          Row(children: [
            Text("Nome Camisola: ", style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 70, 202, 255)),),
            Text(_jogador.nomeCamisola, style: TextStyle(color: Colors.white))
          ],),
          Row(children: [
            Text("Idade: ", style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 70, 202, 255)),),
            Text("${calculateAge(dateFormat.format(_jogador.dataNascimento))} (${dateFormat.format(_jogador.dataNascimento)})", style: TextStyle(color: Colors.white))
          ],),
          Row(children: [
            Text("Nacionalidade: ", style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 70, 202, 255)),),
            Text(_jogador.nacionalidade, style: TextStyle(color: Colors.white))
          ],),
          Row(children: [
            Text("Posição: ", style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 70, 202, 255)),),
            Text(_jogador.posicao, style: TextStyle(color: Colors.white))
          ],),
          Row(children: [
            Text("Altura: ", style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 70, 202, 255)),),
            Text("${_jogador.altura} cms", style: TextStyle(color: Colors.white))
          ],),
          Row(children: [
            Text("Peso: ", style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 70, 202, 255)),),
            Text("${_jogador.peso} kg", style: TextStyle(color: Colors.white))
          ],),
          Row(children: [
            Text("Escolaridade: ", style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 70, 202, 255)),),
            Text(_jogador.escolaridade, style: TextStyle(color: Colors.white))
          ],),
          Row(children: [
            Text("Passaporte: ", style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 70, 202, 255)),),
            Text(_jogador.passaporte, style: TextStyle(color: Colors.white))
          ],),
          Row(children: [
            Text("Data do Último Controlo Anti-Doping: ", style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 70, 202, 255)),),
            Text(dateFormat.format(_jogador.ultimoControloDoping), style: TextStyle(color: Colors.white))
          ],),
        ];
      });
    });
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
        _historico.deleteJogador(_jogador.passaporte);
        FirebaseFirestore.instance.collection("jogadores").doc(_jogador.passaporte).delete();
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

  //Método para calcular a idade
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
    //Abrir menu admin
    setState(() {
      admin = true;
    });
  }

  @override
  void close() {
    //Fechar menu admin
    setState(() {
      admin = false;
    });
  }

  //Atualizar Histórico de Carreira de Jogador
  Future<HistoricoJogador> update() async {
    
    if (_historico.list.isEmpty){
      await _historico.getHistorico(widget.passaporte);
      historico = _historico.list;
    } 
    setState(() {
      
    });
    return _historico;
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: DefaultAppBar(texto: "${widget.jogador}"),
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
                Column(
                  children: [
                    Container(
                      color: Color.fromARGB(255, 12, 13, 20).withOpacity(0.8),
                      width: double.infinity,
                      margin: const EdgeInsets.all(50),
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      child: Column(
                        children: infopessoal
                      ),
                      
                    ),
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
                              columns:  [
                                const DataColumn(label: Text('Clube')),
                                DataColumn(label: Text((admin == false) ? 'Camisola' : 'Remover')),
                                const DataColumn(label: Text('Início')),
                                const DataColumn(label: Text('Fim')),
                              ],
                              rows: historico
                                  .map((Contrato j) => DataRow(cells: [
                                    DataCell(
                                      InkWell(
                                        child: Text(j.clube),
                                        onTap: () => Navigator.pushNamed(context, '${ClubeScreen.routeName}/${j.clube}')
                                      ),
                                    ),
                                    DataCell((admin == false) ? 
                                      Text(j.numeroCamisola.toString()) : 
                                      InkWell(
                                        child: Icon(Icons.delete, color:Color.fromARGB(255, 213, 84, 84)),
                                        onTap: () {
                                          _historico.deleteJogador(j.jogador, clube: j.clube);
                                          setState(() {
                                            historico.remove(j);
                                          });
                                        }
                                      ),
                                    ),
                                    DataCell(Text(dateFormat.format(j.inicioContrato).toString())),
                                    DataCell(Text(dateFormat.format(j.fimContrato).toString())),
                                  ])).toList(),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        return CircularProgressIndicator();
                      },
                    ),
                  ]
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
            heroTag: "EditJogador",
            backgroundColor: Color.fromARGB(255, 12, 0, 62),
            child: const Icon(Icons.edit),
            onPressed: () {
              Navigator.pushNamed(context, AddJogador.routeName+"/"+_jogador.passaporte);
            },
          ),
          FloatingActionButton.small(
            heroTag: "DeleteJogador",
            backgroundColor: Color.fromARGB(255, 140, 0, 0),
            child: const Icon(Icons.delete),
            onPressed: () {
              var what = showConfirmationBox(context);
            },
          ),
          FloatingActionButton.small(
            heroTag: "AddClubeJogador",
            backgroundColor: Color.fromARGB(255, 12, 0, 62),
            child: const Icon(Icons.add_moderator),
            onPressed: () {
              Navigator.pushNamed(context, JogadoresInscritos.routeName+"/jogador/"+_jogador.passaporte);
            },
          ),
          
        ],
      ), 
    );
  }
}