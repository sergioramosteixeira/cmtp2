import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/models/jogador.dart';
import 'package:flutter_application_1/screens/adminscreen.dart';
import 'package:flutter_application_1/screens/jogadoresinscritos.dart';
import 'package:flutter_application_1/screens/mainmenu.dart';
import 'package:flutter_application_1/widgets/defaultappbar.dart';

class AddJogador extends StatefulWidget{
  static final String routeName = '/addjogador';
  final String? passaporte;
  AddJogador({this.passaporte});

  @override
  State<AddJogador> createState() => _AddJogadorState();
}

class _AddJogadorState extends State<AddJogador> {
  final nomeCompleto = TextEditingController();

  final nomeCamisola = TextEditingController();

  final escolaridade = TextEditingController();

  final dataNascimento = TextEditingController();

  final nacionalidade = TextEditingController();

  String posicao = "Guarda-Redes";

  final peso = TextEditingController();

  final altura = TextEditingController();

  final passaporte = TextEditingController();

  final ultimoControloDoping = TextEditingController();

  String textButton = "Adicionar Jogador";

  Future<DateTime?> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2023, 1),
      firstDate: DateTime(1950, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null)
      setState(() {
        controller.text = picked.toString();
      });
    return picked;
  }

  @override
  void initState() {
    super.initState();

    if(widget.passaporte != null){
        updateJogador();
    }    
  }

  @override
  void updateJogador() async {
    Jogador jogador;
    await FirebaseFirestore.instance.collection("jogadores").where("passaporte", isEqualTo: widget.passaporte).get().then((snapshot) {
      snapshot.docs.forEach((document) {
        jogador = Jogador.fromJson(document);

        nomeCompleto.text=jogador.nomeCompleto;
        nomeCamisola.text=jogador.nomeCamisola;
        escolaridade.text=jogador.escolaridade;
        dataNascimento.text=jogador.dataNascimento.toString();
        nacionalidade.text=jogador.nacionalidade;
        peso.text=jogador.peso.toString();
        altura.text=jogador.altura.toString();
        passaporte.text=jogador.passaporte;
        ultimoControloDoping.text=jogador.ultimoControloDoping.toString();
        posicao=jogador.posicao;
        textButton = "Alterar Jogador";
      });
    });
    setState(() {
      
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
              TextField(
                controller: nomeCompleto,
                decoration: const InputDecoration(
                  labelText: "Nome Completo",
                ),
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: nomeCamisola,
                decoration: const InputDecoration(
                  labelText: "Nome Camisola",
                ),
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: escolaridade,
                decoration: const InputDecoration(
                  labelText: "Escolaridade",
                ),
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: nacionalidade,
                decoration: const InputDecoration(
                  labelText: "Nacionalidade",
                ),
                keyboardType: TextInputType.text,
              ),
              DropdownButtonFormField<String>(
                isExpanded: true,
                value: posicao,
                decoration: const InputDecoration(
                  labelText: "Posição",
                ),
                items: const [
                  DropdownMenuItem(
                    child: Text("Guarda-Redes"),
                    value: "Guarda-Redes",
                  ),
                  DropdownMenuItem(
                    child: Text("Defesa"),
                    value: "Defesa",
                  ),
                  DropdownMenuItem(
                    child: Text("Médio"),
                    value: "Médio",
                  ),
                  DropdownMenuItem(
                    child: Text("Avançado"),
                    value: "Avançado",
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    posicao = value!;
                  });
                },
              ),
              TextField(
                controller: dataNascimento,
                decoration: const InputDecoration(
                  labelText: "Data de Nascimento",
                ),
                keyboardType: TextInputType.datetime,
                onTap: () => _selectDate(context, dataNascimento).then((date) {
                  if (date != null)
                    dataNascimento.text =
                        "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
                }),
              ),
              TextField(
                controller: peso,
                decoration: const InputDecoration(
                  labelText: "Peso (Kg)",
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
              TextField(
                controller: altura,
                decoration: const InputDecoration(
                  labelText: "Altura (cms)",
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
              TextField(
                enabled: (widget.passaporte==null) ? true : false,
                controller: passaporte,
                decoration: const InputDecoration(
                  labelText: "Passaporte",
                ),
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: ultimoControloDoping,
                decoration: const InputDecoration(
                  labelText: "Último Controlo Anti-Doping",
                ),
                keyboardType: TextInputType.datetime,
                onTap: () => _selectDate(context, ultimoControloDoping).then((date) {
                  if (date != null)
                    ultimoControloDoping.text = "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
                }),
              ),
              ElevatedButton(
                onPressed: () {
                  int pesoInt = int.parse(peso.text);
                  int alturaInt = int.parse(altura.text);
                  FirebaseFirestore.instance
                    .collection("jogadores")
                    .doc(passaporte.text)
                    .set({
                      "nomeCompleto": nomeCompleto.text, 
                      "nomeCamisola": nomeCamisola.text,
                      "escolaridade": escolaridade.text,
                      "nacionalidade": nacionalidade.text,
                      "posicao": posicao,
                      "dataNascimento": dataNascimento.text,
                      "peso": pesoInt,
                      "altura": alturaInt,
                      "passaporte": passaporte.text,
                      "ultimoControloDoping": ultimoControloDoping.text,
                    });
                  if(widget.passaporte==null) {
                    Navigator.pushNamed(context, JogadoresInscritos.routeName+"/jogador/"+passaporte.text);
                    JogadoresInscritos(); 
                  }else{
                    Navigator.pushReplacementNamed(context, MainMenu.routeName);
                  }
                  
                  
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
                child: Text(
                 textButton,
                ),
              ),
            ]
          )
        ),
      )
    );
  }
}