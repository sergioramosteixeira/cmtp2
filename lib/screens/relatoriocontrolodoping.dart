import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/data/antidopings.dart';
import 'package:flutter_application_1/data/contratos.dart';
import 'package:flutter_application_1/data/jogadores.dart';
import 'package:flutter_application_1/models/antidoping.dart';
import 'package:flutter_application_1/models/clube.dart';
import 'package:flutter_application_1/models/contrato.dart';
import 'package:flutter_application_1/models/jogador.dart';
import 'package:flutter_application_1/screens/adminscreen.dart';
import 'package:flutter_application_1/widgets/defaultappbar.dart';
import 'package:intl/intl.dart';

class RelatorioControloDoping extends StatefulWidget{
  static final String routeName = '/relatoriocontrolodoping';
  

  @override
  State<RelatorioControloDoping> createState() => _RelatorioControloDopingState();
}

  
class _RelatorioControloDopingState extends State<RelatorioControloDoping> {

  int dias = 60;
  
  final Antidopings _jogadores = Antidopings();
  
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  Clube _clube = Clube(capacidadeEstadio: 0, fundado: 0, cidadeEstadio: '', logo: '', moradaEstadio: '', nome: '', nomeEstadio: '', pais: '', sigla: '');
  String _liga = "BWIN";
  List<DropdownMenuItem<Clube>> _options = [];
  String _grupo = "A";
  bool _isDropdownVisible = false;
  List<String> clubes = [];
  final _firestore = FirebaseFirestore.instance;
  TextEditingController numberController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }


  void changeDias() {
    numberController = TextEditingController(text: dias.toString());
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Número de dias"),
          content: TextField(
            controller: numberController,
            decoration: InputDecoration(labelText: "Número de dias"),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            keyboardType: TextInputType.number,
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  dias = int.parse(numberController.text);
                });
              },
            ),
          ],
        );
      },
    );
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
              Row(children: [
                Text("Jogadores que não fazem controlo antidoping há mais de "),
                ElevatedButton(
                  onPressed: () => changeDias(),
                  child: Text(dias.toString())),
                Text(" dias."),
              ],),
              FutureBuilder<List<dynamic>>(
                future: Future.wait([_jogadores.getJogadores(dias)]),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      width: double.infinity,
                      margin: const EdgeInsets.all(0),
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      child: DataTable(
                        headingRowColor: MaterialStateColor.resolveWith((states) {return Color.fromARGB(255, 12, 0, 62);},),
                        headingTextStyle: const TextStyle(color: Colors.white, fontFamily: 'Changa'),
                        columns: const [
                          DataColumn(label: Text('Jogador')),
                          DataColumn(label: Text('Clube')),
                          DataColumn(label: Text('Controlo')),
                          DataColumn(label: Text('Dias')),
                        ],
                        rows: _jogadores.list
                            .map((Antidoping j) => DataRow(cells: [
                              DataCell(Text(j.jogador.nomeCamisola)),
                              DataCell(Text(j.clube)),
                              DataCell(Text(dateFormat.format(j.jogador.ultimoControloDoping))),
                              DataCell(Text("${DateTime.now().difference(j.jogador.ultimoControloDoping).inDays} dias")),
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
          )
        ),
      )
    );
  }
}