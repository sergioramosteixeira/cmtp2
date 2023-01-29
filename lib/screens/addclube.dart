import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/screens/adminscreen.dart';
import 'package:flutter_application_1/screens/clubesinscritos.dart';
import 'package:flutter_application_1/widgets/defaultappbar.dart';

class AddClube extends StatelessWidget{
  static final String routeName = '/addclube';

  final nome = TextEditingController();
  final sigla = TextEditingController();
  final logo = TextEditingController();
  final fundado = TextEditingController();
  final pais = TextEditingController();
  final nomeEstadio = TextEditingController();
  final moradaEstadio = TextEditingController();
  final cidadeEstadio = TextEditingController();
  final capacidadeEstadio = TextEditingController();


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
                controller: nome,
                decoration: const InputDecoration(
                  labelText: "Nome do Clube",
                ),
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: sigla,
                decoration: const InputDecoration(
                  labelText: "Sigla do Clube",
                ),
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: logo,
                decoration: const InputDecoration(
                  labelText: "URL do Logo do Clube",
                ),
                keyboardType: TextInputType.url,
              ),
              TextField(
                controller: pais,
                decoration: const InputDecoration(
                  labelText: "País",
                ),
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: fundado,
                decoration: const InputDecoration(
                  labelText: "Ano de Fundação",
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
              TextField(
                controller: nomeEstadio,
                decoration: const InputDecoration(
                  labelText: "Nome do Estádio",
                ),
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: moradaEstadio,
                decoration: const InputDecoration(
                  labelText: "Morada do Estádio",
                ),
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: cidadeEstadio,
                decoration: const InputDecoration(
                  labelText: "Cidade do Estádio",
                ),
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: capacidadeEstadio,
                decoration: const InputDecoration(
                  labelText: "Capacidade do Estádio",
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  int fundadoInt = int.parse(fundado.text);
                  int capacidadeEstadioInt = int.parse(capacidadeEstadio.text);
                  FirebaseFirestore.instance
                    .collection("clubes")
                    .doc(sigla.text)
                    .set({
                      "nome": nome.text, 
                      "sigla": sigla.text,
                      "logo": logo.text,
                      "pais": pais.text,
                      "fundado": fundadoInt,
                      "nomeEstadio": nomeEstadio.text,
                      "moradaEstadio": moradaEstadio.text,
                      "cidadeEstadio": cidadeEstadio.text,
                      "capacidadeEstadio": capacidadeEstadioInt,
                    });

                  Navigator.pushNamed(context, ClubesInscritos.routeName);
                  ClubesInscritos(); 
                  
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
                 'Adicionar Clube',
                ),
              ),
            ]
          )
        ),
      )
    );
  }
}