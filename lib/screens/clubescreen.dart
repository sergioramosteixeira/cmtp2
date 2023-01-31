import 'package:flutter/material.dart';
import 'package:flutter_application_1/buttons/admin_button.dart';
import 'package:flutter_application_1/data/classificacoes.dart';
import 'package:flutter_application_1/data/clubes.dart';
import 'package:flutter_application_1/data/jogadores.dart';
import 'package:flutter_application_1/data/jogos.dart';
import 'package:flutter_application_1/models/classificacao.dart';
import 'package:flutter_application_1/models/clube.dart';
import 'package:flutter_application_1/models/jogador.dart';
import 'package:flutter_application_1/models/jogo.dart';
import 'package:flutter_application_1/screens/jogadorscreen.dart';
import 'package:flutter_application_1/widgets/defaultappbar.dart';

import 'package:intl/intl.dart';


class ClubeScreen extends StatefulWidget{
  static const String routeName = '/clube';
  final String clube;
  ClubeScreen({required this.clube});
  

  @override
  _ClubeScreenState createState() => _ClubeScreenState();
}

class _ClubeScreenState extends State<ClubeScreen> {
  final Clubes _clubes = Clubes();
  final Jogadores _jogadores = Jogadores();
  final Classificacoes _classif = Classificacoes();
  List<int> _jornadas = [];
  
  Clube? _clube;
  
  int jornada = 3;

  bool _nextEnabled = true;
  bool _previousEnabled = true;

  DateFormat dateFormat = DateFormat("yyyy-MM-dd");


  @override
  void initState() {
    super.initState();
    
    _clubes.getClubes();
    setState(() {
      
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
      appBar: DefaultAppBar(texto: "${widget.clube}"),
      body: SizedBox.expand(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("../img/stadium.jpg"),
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
                              
                          FutureBuilder<List<dynamic>>(
                            future: Future.wait([_jogadores.getJogadores(_clube!)]),
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
                                      DataColumn(label: Text('Jogador')),
                                      DataColumn(label: Text('País')),
                                      DataColumn(label: Text('Posição')),
                                      DataColumn(label: Text('Idade')),
                                    ],
                                    rows: _jogadores.list
                                        .map((Jogador j) => DataRow(cells: [
                                          DataCell(
                                            InkWell(
                                              child: Text(j.nomeCamisola),
                                              onTap: () => Navigator.pushNamed(context, '${JogadorScreen.routeName}/${j.passaporte}/${j.nomeCamisola}')
                                            ),
                                          ),
                                          DataCell(Text(j.nacionalidade)),
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
      )
    );
  }
}