import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/models/clube.dart';
import 'package:flutter_application_1/screens/adminscreen.dart';
import 'package:flutter_application_1/screens/leaguehome.dart';
import 'package:flutter_application_1/widgets/defaultappbar.dart';

class AddJogo extends StatefulWidget{
  //Screen de adicionar jogo

  static const String routeName = '/addjogo'; //Rota
  String? liga;       //Se o parâmetro liga não for nulo, é preenchido automático
  AddJogo({this.liga});

  @override
  State<AddJogo> createState() => _AddJogoState();
}

  
class _AddJogoState extends State<AddJogo> {

  final arbitro = TextEditingController();
  final dataJogo = TextEditingController();
  final estadio = TextEditingController();
  final golosCasa = TextEditingController();
  final golosFora = TextEditingController();
  
  int jornada = 1;

  Clube _clubeCasa = Clube(capacidadeEstadio: 0, fundado: 0, cidadeEstadio: '', logo: '', moradaEstadio: '', nome: '', nomeEstadio: '', pais: '', sigla: '');
  Clube _clubeFora = Clube(capacidadeEstadio: 0, fundado: 0, cidadeEstadio: '', logo: '', moradaEstadio: '', nome: '', nomeEstadio: '', pais: '', sigla: '');
  String _liga = "BWIN";
  List<String> clubes = [];
  List<DropdownMenuItem<Clube>> _options = [];
  List<DropdownMenuItem<int>> _jornadas = [];

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
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      setState(() {
        controller.text = DateTime(
          picked.year,
          picked.month,
          picked.day,
          time!.hour,
          time.minute,
        ).toString();
      });
      return DateTime(picked.year,picked.month,picked.day, time!.hour,time.minute);
    }
    else {
      return DateTime(picked!.year,picked.month,picked.day);
    }
  }

  @override
  void initState() {
    super.initState();
    //Se o parâmetro liga não for nulo, é preenchido automático
    (widget.liga == null) ? _liga = _liga : _liga=widget.liga!;

    update(_liga);
  }

  @override
  void update(String l) {
    //Atualização dos DropdownMenus conforme a liga selecionada
    _jornadas = [];

    //Para as jornadas, em campeonato são 34 jornadas, na taça são 4 jornadas + quartos + meias + final
    if (_liga == "Allianz"){
      for(var i = 1; i <= 4; i++){
        _jornadas.add(
          DropdownMenuItem(
            child: Text('$i'),
            value: i,
          ),
        );
      }
      _jornadas.add(
        const DropdownMenuItem(
          child: Text('Quartos-Final'),
          value: 97,
        ),
      );
      _jornadas.add(
        const DropdownMenuItem(
          child: Text('Meia-Final'),
          value: 98,
        ),
      );
      _jornadas.add(
        const DropdownMenuItem(
          child: Text('Final'),
          value: 99,
        ),
      );
    }else{
      for(var i = 1; i <= 34; i++){
        _jornadas.add(
          DropdownMenuItem(
            child: Text('$i'),
            value: i,
          ),
        );
      }
    }

    //Preencher os dropdownMenus com os clubes inscritos na liga selecionada
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
        _clubeCasa = _options[0].value!;
        _clubeFora = _options[0].value!;
        //Atualizar o campo de Estadio com o nome do Estádio da equipa de casa
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
                    update(value);
                    
                  });
                },
              ),
              DropdownButton<int>(
                isExpanded: true,
                value: jornada,
                items: _jornadas,
                onChanged: (value) {
                  setState(() {
                    jornada = value!;
                  });
                },
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
                            //Atualizar o campo de Estadio com o nome do Estádio da equipa de casa selecionada
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
                onTap: () => _selectDate(context, dataJogo).then((date) {
                  if (date != null) {
                    print(date);
                    //Formato da data
                    dataJogo.text = "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
                  }
                }),
              ),
              ElevatedButton(
                onPressed: () {
                  int golosCasaInt = int.parse(golosCasa.text);
                  int golosForaInt = int.parse(golosFora.text);

                  //Adicionar no Firestore
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
                      "jornada": jornada,
                      "dataJogo": dataJogo.text,
                    });

                  //Se a liga não tiver sido mencionada, vai para a página do menu admin
                  //Se a liga tiver sido mencionada, vai para a página dessa liga
                  (widget.liga == null) ?
                    Navigator.popUntil(context, ModalRoute.withName(AdminScreen.routeName)) :
                    Navigator.pushReplacementNamed(context, LeagueHome.routeName+"/"+widget.liga!);
                  
                },
                //Estilo do botão de Adicionar
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