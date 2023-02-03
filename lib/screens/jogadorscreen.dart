import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/buttons/admin_button.dart';
import 'package:flutter_application_1/data/classificacoes.dart';
import 'package:flutter_application_1/data/clubes.dart';
import 'package:flutter_application_1/data/historicojogador.dart';
import 'package:flutter_application_1/data/jogadores.dart';
import 'package:flutter_application_1/data/jogos.dart';
import 'package:flutter_application_1/models/classificacao.dart';
import 'package:flutter_application_1/models/clube.dart';
import 'package:flutter_application_1/models/contrato.dart';
import 'package:flutter_application_1/models/jogador.dart';
import 'package:flutter_application_1/models/jogo.dart';
import 'package:flutter_application_1/screens/adminscreen.dart';
import 'package:flutter_application_1/widgets/defaultappbar.dart';

import 'package:intl/intl.dart';

import 'clubescreen.dart';


class JogadorScreen extends StatefulWidget{
  static const String routeName = '/jogador';
  final String passaporte;
  final String jogador;
  JogadorScreen({required this.passaporte, required this.jogador});
  

  @override
  _JogadorScreenState createState() => _JogadorScreenState();
}

class _JogadorScreenState extends State<JogadorScreen> {
  List<int> _jornadas = [];
  
  final HistoricoJogador _historico = HistoricoJogador();

  Jogador _jogador = Jogador(nomeCompleto: "a", nomeCamisola: "a", escolaridade: "a", nacionalidade: "a", posicao: "a", dataNascimento: DateTime(2000,1,1), peso: 0, altura: 0, passaporte: 'a', ultimoControloDoping: DateTime(2000,1,1));
  
  int jornada = 3;

  bool _nextEnabled = true;
  bool _previousEnabled = true;

  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  final _firestore = FirebaseFirestore.instance;

  List<Widget> teste = [ ];

  @override
  void initState() {
    super.initState();
    fetchData();
    
    setState(() {
      
    });
  }

  @override
  void fetchData() {
    _firestore.collection("jogadores").where("passaporte", isEqualTo: widget.passaporte).get().then((snapshot) {
      snapshot.docs.forEach((document) {
        _jogador=Jogador.fromJson(document);
      });

      setState(() {
        teste = [ 
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
                        children: teste
                      ),
                      
                    ),
                    FutureBuilder<List<dynamic>>(
                      future: Future.wait([_historico.getHistorico(widget.passaporte)]),
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
                              columns: const [
                                DataColumn(label: Text('Clube')),
                                DataColumn(label: Text('Início')),
                                DataColumn(label: Text('Fim')),
                                DataColumn(label: Text('Camisola')),
                              ],
                              rows: _historico.list
                                  .map((Contrato j) => DataRow(cells: [
                                    DataCell(
                                      InkWell(
                                        child: Text(j.clube),
                                        onTap: () => Navigator.pushNamed(context, '${ClubeScreen.routeName}/${j.clube}')
                                      ),
                                    ),
                                    DataCell(Text(dateFormat.format(j.inicioContrato).toString())),
                                    DataCell(Text(dateFormat.format(j.fimContrato).toString())),
                                    DataCell(Text(j.numeroCamisola.toString())),
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
      )
    );
  }
}