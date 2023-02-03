import 'package:flutter/material.dart';
import 'package:flutter_application_1/buttons/admin_button.dart';
import 'package:flutter_application_1/widgets/defaultappbar.dart';

class AdminScreen extends StatefulWidget{
  //Screen do Menu de Administração

  static final String routeName = '/adminscreen';

  @override
  _AdminScreen createState() => _AdminScreen();
}

class _AdminScreen extends State<AdminScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(logo: "lp"),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("img/stadium.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(0),
              padding: const EdgeInsets.all(10),
              child: AdminButton('Adicionar Clubes'),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(0),
              padding: const EdgeInsets.all(10),
              child: AdminButton('Adicionar Jogos'),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(0),
              padding: const EdgeInsets.all(10),
              child: AdminButton('Adicionar Jogadores'),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(0),
              padding: const EdgeInsets.all(10),
              child: AdminButton('Jogadores Inscritos'),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(0),
              padding: const EdgeInsets.all(10),
              child: AdminButton('Clubes Inscritos'),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(0),
              padding: const EdgeInsets.all(10),
              child: AdminButton('Relatório de Jogadores Ativos'),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(0),
              padding: const EdgeInsets.all(10),
              child: AdminButton('Relatório de Contratos a Expirar'),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(0),
              padding: const EdgeInsets.all(10),
              child: AdminButton('Relatório de Controlos Antidoping'),
            ),
          ]
        )
      )
    );
  }
}