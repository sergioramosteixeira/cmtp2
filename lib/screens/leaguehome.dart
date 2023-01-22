import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/buttons/admin_button.dart';
import 'package:flutter_application_1/buttons/allianz_button.dart';
import 'package:flutter_application_1/buttons/bwin_button.dart';
import 'package:flutter_application_1/buttons/sabseg_button.dart';
import 'package:flutter_application_1/data/clubes.dart';
import 'package:flutter_application_1/data/jogos.dart';
import 'package:flutter_application_1/models/clube.dart';
import 'package:flutter_application_1/models/jogo.dart';
import 'package:flutter_application_1/widgets/defaultappbar.dart';
import 'package:provider/provider.dart';

class LeagueHome extends StatefulWidget{
  static const String routeName = '/leaguehome';
  final String logo;
  LeagueHome({required this.logo});

  @override
  _LeagueHomeState createState() => _LeagueHomeState();
}

class _LeagueHomeState extends State<LeagueHome> {
  final Clubes _clubes = Clubes();
  final Jogos _jogos = Jogos();
  
  void alert(){
    print('Avoid error!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(logo: "${widget.logo}_h"),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("../img/stadium.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            FutureBuilder<List<Clube>>(
              future: _clubes.getClubes(),
              builder: (context, snapshot) {
                return Text("");
              },
            ),
            FutureBuilder<List<Jogo>>(
              future: _jogos.getJogos(_clubes),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(0),
                    padding: const EdgeInsets.all(10),
                    color: const Color.fromARGB(255, 12, 13, 20).withOpacity(0.5), 
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _jogos.list
                            .map((Jogo c) => Text(c.toString(), style: TextStyle(color: Colors.white)))
                            .toList(),
                      ),
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
        )
      )
    );
  }
}