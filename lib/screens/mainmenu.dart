import 'package:flutter/material.dart';
import 'package:flutter_application_1/buttons/admin_button.dart';
import 'package:flutter_application_1/buttons/allianz_button.dart';
import 'package:flutter_application_1/buttons/bwin_button.dart';
import 'package:flutter_application_1/buttons/sabseg_button.dart';
import 'package:flutter_application_1/widgets/defaultappbar.dart';

class MainMenu extends StatefulWidget{
  //Screen do Menu Principal

  static final String routeName = '/'; //Rota

  @override
  _MainMenu createState() => _MainMenu();
}

class _MainMenu extends State<MainMenu> {

  int currentMenu = 0;

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
              child: BwinButton('Liga BWIN'),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(0),
              padding: const EdgeInsets.all(10),
              child: SabsegButton('Liga Sabseg'),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(0),
              padding: const EdgeInsets.all(10),
              child: AllianzButton('Allianz Cup'),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(0),
              padding: const EdgeInsets.all(10),
              child: AdminButton('Admin'),
            ),
            const Text(
              "Desenvolvido por Lara Figueiredo e Sérgio Teixeira", style: TextStyle(color: Colors.white)),
            const Text("Computação Móvel - ISPGAYA - 2023", style: TextStyle(color: Colors.yellow)),
          ]
        )
      )
    );
  }
}