import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/contratos.dart';
import 'package:flutter_application_1/models/clube.dart';
import 'package:flutter_application_1/models/contrato.dart';
import 'package:flutter_application_1/widgets/defaultappbar.dart';
import 'package:intl/intl.dart';

class RelatorioRenovacoes extends StatefulWidget{
  //Screen do Relatorio de Contratos a Expirar

  static final String routeName = '/relatoriorenovacoes'; //rota
  

  @override
  State<RelatorioRenovacoes> createState() => _RelatorioRenovacoesState();
}

  
class _RelatorioRenovacoesState extends State<RelatorioRenovacoes> {

  final Contratos _contratos = Contratos();
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  Clube _clube = Clube(capacidadeEstadio: 0, fundado: 0, cidadeEstadio: '', logo: '', moradaEstadio: '', nome: '', nomeEstadio: '', pais: '', sigla: '');
  String _liga = "BWIN";
  List<DropdownMenuItem<Clube>> _options = [];
  List<String> clubes = [];
  final _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    updateClubes(_liga);
  }

  @override
  void updateClubes(String l) {
    //Atualizar lista de clubes conforme a liga selecionada
    _options = [];
    clubes = [];
    _firestore.collection("clubesLiga").where("liga", isEqualTo: l).get().then((snapshot) {
      snapshot.docs.forEach((document) {
        clubes.add(document["clube"]);
      });
    });
    _firestore.collection("clubes").get().then((snapshot) {
      snapshot.docs.forEach((document) {
        if (clubes.contains(document["sigla"])){
          _options.add(
            DropdownMenuItem(
              child: Text(document["sigla"]),
              value: Clube.fromJson(document),
            ),
          );
        }
      });
      if (_options.isNotEmpty) {
        _clube = _options[0].value!;
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
              DropdownButton<String>(
                isExpanded: true,
                value: _liga,
                items: const [
                  DropdownMenuItem(
                    child: Text("Liga BWIN"),
                    value: "BWIN",
                  ),
                  DropdownMenuItem(
                    child: Text("Liga Sabseg"),
                    value: "Sabseg",
                  ),
                  DropdownMenuItem(
                    child: Text("Allianz Cup"),
                    value: "Allianz",
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    updateClubes(value!);
                    _liga = value;
                  });
                },
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
              FutureBuilder<List<dynamic>>(
                future: Future.wait([_contratos.getContratos(_clube, "a expirar")]),
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
                          DataColumn(label: Text('Fim de Contrato')),
                          DataColumn(label: Text('Dias Restantes')),
                        ],
                        rows: _contratos.list
                            .map((Contrato j) => DataRow(cells: [
                              DataCell(Text(j.jogador)),
                              DataCell(Text(dateFormat.format(j.fimContrato))),
                              DataCell(Text("${j.fimContrato.difference(DateTime.now()).inDays} dias")),
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