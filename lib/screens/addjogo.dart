import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/models/clube.dart';
import 'package:flutter_application_1/screens/adminscreen.dart';
import 'package:flutter_application_1/widgets/defaultappbar.dart';

class AddJogo extends StatefulWidget{
  static final String routeName = '/addjogo';
  

  @override
  State<AddJogo> createState() => _AddJogoState();
}

  
class _AddJogoState extends State<AddJogo> {

  final arbitro = TextEditingController();
  final dataJogo = TextEditingController();
  final estadio = TextEditingController();
  final golosCasa = TextEditingController();
  final golosFora = TextEditingController();
  final jornada = TextEditingController();

  int currentMenu = 0;

  Clube _clubeCasa = Clube(capacidadeEstadio: 0, fundado: 0, cidadeEstadio: '', logo: '', moradaEstadio: '', nome: '', nomeEstadio: '', pais: '', sigla: '');
  Clube _clubeFora = Clube(capacidadeEstadio: 0, fundado: 0, cidadeEstadio: '', logo: '', moradaEstadio: '', nome: '', nomeEstadio: '', pais: '', sigla: '');
  String _liga = "BWIN";
  List<DropdownMenuItem<Clube>> _options = [];

  final _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _options = [];
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
        _clubeCasa = _options[0].value!;
        _clubeFora = _options[0].value!;
        estadio.text = _options[0].value!.nomeEstadio;
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
                    _liga = value!;
                  });
                },
              ),
              TextField(
                controller: jornada,
                decoration: const InputDecoration(
                  labelText: "Jornada",
                ),
                keyboardType: TextInputType.text,
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: DropdownButton<Clube>(
                        isExpanded: true,
                        value: _clubeCasa,
                        items: _options,
                        onChanged: (value) {
                          setState(() {
                            _clubeCasa = value!;
                            estadio.text = value.nomeEstadio;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(child: Center(child: Text(" vs ")), width: MediaQuery.of(context).size.width * 0.1),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: DropdownButton<Clube>(
                        isExpanded: true,
                        value: _clubeFora,
                        items: _options,
                        onChanged: (value) {
                          setState(() {
                            _clubeFora = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextField(
                      controller: golosCasa,
                      decoration: const InputDecoration(
                        labelText: "Golos Casa",
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                  SizedBox(child: Center(child: Text("  ")), width: MediaQuery.of(context).size.width * 0.1),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextField(
                      controller: golosFora,
                      decoration: const InputDecoration(
                        labelText: "Golos Fora",
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                ],
              ),
              TextField(
                controller: arbitro,
                decoration: const InputDecoration(
                  labelText: "Árbitro do Jogo",
                ),
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: estadio,
                decoration: const InputDecoration(
                  labelText: "Estádio",
                ),
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: dataJogo,
                decoration: const InputDecoration(
                  labelText: "Data e Hora do Jogo",
                ),
                keyboardType: TextInputType.datetime,
              ),
             
              ElevatedButton(
                onPressed: () {
                  int golosCasaInt = int.parse(golosCasa.text);
                  int golosForaInt = int.parse(golosFora.text);
                  FirebaseFirestore.instance
                    .collection("jogos")
                    .doc(dataJogo.text+"_"+_clubeCasa.sigla+"_"+_clubeFora.sigla)
                    .set({
                      "clubeCasa": _clubeCasa.sigla, 
                      "clubeFora": _clubeFora.sigla, 
                      "golosCasa": golosCasaInt,
                      "golosFora": golosForaInt,
                      "estadio": estadio.text,
                      "arbitro": arbitro.text,
                      "liga": _liga,
                      "jornada": jornada.text,
                      "dataJogo": dataJogo.text,
                    });

                  Navigator.pushNamed(context, AdminScreen.routeName);
                  AdminScreen(); 
                  
                },
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
                 'Adicionar Jogo',
                ),
              ),
            ]
          )
        ),
      )
    );
  }
}