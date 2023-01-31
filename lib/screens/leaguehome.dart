import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/buttons/admin_button.dart';
import 'package:flutter_application_1/data/classificacoes.dart';
import 'package:flutter_application_1/data/clubes.dart';
import 'package:flutter_application_1/data/jogos.dart';
import 'package:flutter_application_1/models/classificacao.dart';
import 'package:flutter_application_1/models/clube.dart';
import 'package:flutter_application_1/models/jogo.dart';
import 'package:flutter_application_1/screens/adminscreen.dart';
import 'package:flutter_application_1/screens/clubescreen.dart';
import 'package:flutter_application_1/widgets/defaultappbar.dart';

import 'package:intl/intl.dart';


class LeagueHome extends StatefulWidget{
  static const String routeName = '/leaguehome';
  final String liga;
  LeagueHome({required this.liga});
  

  @override
  _LeagueHomeState createState() => _LeagueHomeState();
}

List<int> getJornadas(String liga) {
    List<int> jornadas = [];
    switch (liga) {
      case "Allianz":
        jornadas.add(1);
        jornadas.add(2);
        jornadas.add(3);
        jornadas.add(4);
        jornadas.add(97);
        jornadas.add(98);
        jornadas.add(99);
        break;
      default:
        for(var i = 1; i<=34; i++) {
          jornadas.add(i);
        }
    }
    return jornadas;
}


class _LeagueHomeState extends State<LeagueHome> {
  
  final Clubes _clubes = Clubes();
  final Jogos _jogos = Jogos();
  final Classificacoes _classif = Classificacoes();
  List<int> _jornadas = [];
  
  int jornada = 3;

  bool _nextEnabled = true;
  bool _previousEnabled = true;

  DateFormat dateFormat = DateFormat("dd-MM HH:mm");


  @override
  void initState() {
    _jornadas = getJornadas(widget.liga);
    super.initState();
    _clubes.getClubes();
    setState(() {
      
    });
  }


  void next() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _jornadas.indexOf(jornada) < _jornadas.length - 2 ? _previousEnabled = true : _nextEnabled = false;
        _jornadas.indexOf(jornada) < _jornadas.length - 1 ? jornada=_jornadas[_jornadas.indexOf(jornada) + 1] : null;
      });
    });
  }

  void previous() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _jornadas.indexOf(jornada) > 1 ? _nextEnabled = true : _previousEnabled = false;
        _jornadas.indexOf(jornada) > 0 ? jornada=_jornadas[_jornadas.indexOf(jornada) - 1] : null;
      });
    });
  }

  String getJornada(int j){
    switch (j) {
      case 99:
        return "FINAL";
      case 98:
        return "MEIA-FINAL";
      case 97:
        return "QUARTOS-FINAL";
      default:
        return "JORNADA $j";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(logo: "${widget.liga}_h"),
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
                Center(
                  child: Text(
                    getJornada(jornada), style: TextStyle(color: Colors.white)),
                ),
                FutureBuilder<List<dynamic>>(
                  future: Future.wait([_jogos.getJogos(_clubes, widget.liga, jornada)]),
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
                            DataColumn(label: Text('Casa')),
                            DataColumn(label: Text('')),
                            DataColumn(label: Text('Fora')),
                            DataColumn(label: Text('Data')),
                          ],
                          rows: _jogos.list
                              .map((Jogo c) => DataRow(cells: [
                                DataCell(Text(c.clubeCasa.sigla)),
                                DataCell(Text("${c.golosCasa}-${c.golosFora}")),
                                DataCell(Text(c.clubeFora.sigla)),
                                DataCell(Text(dateFormat.format(c.dataJogo))),
                              ])).toList(),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return CircularProgressIndicator();
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _previousEnabled
                      ? ElevatedButton(
                          onPressed: previous, child: Text(getJornada(_jornadas[_jornadas.indexOf(jornada) - 1])),
                        )
                      : Text(""),
                    _nextEnabled
                      ? ElevatedButton(
                          onPressed: next, child: Text(getJornada(_jornadas[_jornadas.indexOf(jornada) + 1])),
                        )
                      : Text(""),
                  ],
                ),
                FutureBuilder<List<dynamic>>(
                  future: Future.wait([_clubes.getClubes(),_classif.getClassificacao(_clubes, widget.liga, jornada)]),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      int pos=1;
                      List<String> grupos = [];
                      List<Widget> widgets = [];
                      (widget.liga == "Allianz") ? grupos = ['A','B','C','D','E','F','G','H'] : grupos = [""];
                      grupos.forEach((grupo) => {
                        pos = 1,
                        widgets.add(Text(grupo)),
                        widgets.add(DataTable(
                          dataTextStyle: const TextStyle(color: Colors.white, fontFamily: 'Changa'),
                          headingRowColor: MaterialStateColor.resolveWith((states) {return Color.fromARGB(255, 70, 202, 255).withOpacity(0.8);},),
                          dataRowColor: MaterialStateColor.resolveWith((states) {return Color.fromARGB(255, 12, 13, 20).withOpacity(0.8);},),
                          columns: const [
                            DataColumn(label: Text('Pos')),
                            DataColumn(label: Text('Clube')),
                            DataColumn(label: Text('J')),
                            DataColumn(label: Text('V-E-D')),
                            DataColumn(label: Text('DG')),
                            DataColumn(label: Text('Pts')),
                          ],
                          rows: _classif.list.where((e) => e.grupo==grupo || widget.liga != "Allianz")
                              .map((Classificacao c) => DataRow(cells: [
                                DataCell(Text((pos++).toString())),
                                DataCell(
                                  InkWell(
                                    child: Text(c.clube.sigla),
                                    onTap: () => Navigator.pushNamed(context, '${ClubeScreen.routeName}/${c.clube.sigla}')
                                  ),
                                ),
                                DataCell(Text(c.jogos.toString())),
                                DataCell(Text("${c.vitorias}-${c.empates}-${c.derrotas}")),
                                DataCell(Text((c.golosMarcados-c.golosSofridos).toString())),
                                DataCell(Text(c.pontos.toString())),
                              ])).toList(),
                        )),
                      });
                      return Container(
                        width: double.infinity,
                        margin: const EdgeInsets.all(0),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: widgets,
                        ),
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