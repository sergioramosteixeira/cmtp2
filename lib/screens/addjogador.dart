import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/screens/adminscreen.dart';
import 'package:flutter_application_1/screens/jogadoresinscritos.dart';
import 'package:flutter_application_1/widgets/defaultappbar.dart';

class AddJogador extends StatelessWidget{
  static final String routeName = '/addjogador';

  final nomeCompleto = TextEditingController();
  final nomeCamisola = TextEditingController();
  final escolaridade = TextEditingController();
  final dataNascimento = TextEditingController();
  final nacionalidade = TextEditingController();
  final posicao = TextEditingController();
  final peso = TextEditingController();
  final altura = TextEditingController();
  final passaporte = TextEditingController();
  final ultimoControloDoping = TextEditingController();

  int currentMenu = 0;


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
              TextField(
                controller: posicao,
                decoration: const InputDecoration(
                  labelText: "Posição",
                ),
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: dataNascimento,
                decoration: const InputDecoration(
                  labelText: "Data de Nascimento",
                ),
                keyboardType: TextInputType.datetime,
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
              ),
              ElevatedButton(
                onPressed: () {
                  int pesoInt = int.parse(peso.text);
                  int alturaInt = int.parse(altura.text);
                  FirebaseFirestore.instance
                    .collection("jogadores")
                    .doc("${passaporte.text}_${nomeCamisola.text}")
                    .set({
                      "nomeCompleto": nomeCompleto.text, 
                      "nomeCamisola": nomeCamisola.text,
                      "escolaridade": escolaridade.text,
                      "nacionalidade": nacionalidade.text,
                      "posicao": posicao.text,
                      "dataNascimento": dataNascimento.text,
                      "peso": pesoInt,
                      "altura": alturaInt,
                      "passaporte": passaporte.text,
                      "ultimoControloDoping": ultimoControloDoping.text,
                    });
                  Navigator.pushNamed(context, JogadoresInscritos.routeName);
                  JogadoresInscritos(); 
                  
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
                 'Adicionar Jogador',
                ),
              ),
            ]
          )
        ),
      )
    );
  }
}