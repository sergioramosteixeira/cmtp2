import 'package:flutter/material.dart';
import 'package:flutter_application_1/buttons/admin_button.dart';
import 'package:flutter_application_1/buttons/allianz_button.dart';
import 'package:flutter_application_1/buttons/bwin_button.dart';
import 'package:flutter_application_1/buttons/sabseg_button.dart';

void main() => runApp(const Lpfp());

class Lpfp extends StatefulWidget {
  const Lpfp({Key? key}) : super(key: key);

  @override
  State<Lpfp> createState() => _LpfpState();
}

class _LpfpState extends State<Lpfp> {
  int currentMenu = 0;

  void alert() {
    setState(() {
      currentMenu = 0;
    });
  }

  void bwin() {
    setState(() {
      currentMenu = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(currentMenu==1){
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Liga BWIN'),
            backgroundColor: Colors.black,
            foregroundColor: Colors.orange,
          ),
          body: Column(
            children: [
              Table(
                children: const [
                  TableRow(children: [
                    Text("Casa Pia AC", style: TextStyle(fontSize: 15.0),textAlign: TextAlign.right,),
                    Text("0-0", style: TextStyle(fontSize: 15.0),textAlign: TextAlign.center,),
                    Text("FC Porto", style: TextStyle(fontSize: 15.0),textAlign: TextAlign.left,),
                  ]),
                  TableRow(children: [
                    Text("SL Benfica", style: TextStyle(fontSize: 15.0),textAlign: TextAlign.right,),
                    Text("1-0", style: TextStyle(fontSize: 15.0),textAlign: TextAlign.center,),
                    Text("Portimonense SC", style: TextStyle(fontSize: 15.0),textAlign: TextAlign.left,),
                  ]),
                ],
              ),
              Container(
                width: double.infinity,
                margin:const EdgeInsets.fromLTRB(20, 40, 20, 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black87,
                    width: 2,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: alert, child: const Text('Jornada Anterior'),
                    ),
                    ElevatedButton(
                      onPressed: alert, child: const Text('Jornada Seguinte'),
                    ),
                  ],
                ),
              ), 
              Table(
                children: const [
                  TableRow(children: [
                    Text("Pos", style: TextStyle(fontSize: 15.0),textAlign: TextAlign.right,),
                    Text("Equipa", style: TextStyle(fontSize: 15.0),textAlign: TextAlign.center,),
                    Text("J", style: TextStyle(fontSize: 15.0),textAlign: TextAlign.left,),
                    Text("DIF", style: TextStyle(fontSize: 15.0),textAlign: TextAlign.left,),
                    Text("Pts", style: TextStyle(fontSize: 15.0),textAlign: TextAlign.left,),
                  ]),
                  TableRow(children: [
                    Text("1.", style: TextStyle(fontSize: 15.0),textAlign: TextAlign.right,),
                    Text("SL Benfica", style: TextStyle(fontSize: 15.0),textAlign: TextAlign.center,),
                    Text("15", style: TextStyle(fontSize: 15.0),textAlign: TextAlign.left,),
                    Text("+28", style: TextStyle(fontSize: 15.0),textAlign: TextAlign.left,),
                    Text("40", style: TextStyle(fontSize: 15.0),textAlign: TextAlign.left,),
                  ]),
                  TableRow(children: [
                    Text("2.", style: TextStyle(fontSize: 15.0),textAlign: TextAlign.right,),
                    Text("SC Braga", style: TextStyle(fontSize: 15.0),textAlign: TextAlign.center,),
                    Text("15", style: TextStyle(fontSize: 15.0),textAlign: TextAlign.left,),
                    Text("+24", style: TextStyle(fontSize: 15.0),textAlign: TextAlign.left,),
                    Text("24", style: TextStyle(fontSize: 15.0),textAlign: TextAlign.left,),
                  ]),
                ],
              ),
            ]
          )
        )
      );
    }else{
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Liga Portuguesa de Futebol Profissional'),
          ),
          body: Column(
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(0),
                padding: const EdgeInsets.all(10),
                child: BwinButton(bwin, 'Liga BWIN'),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(0),
                padding: const EdgeInsets.all(10),
                child: SabsegButton(alert, 'Liga Sabseg'),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(0),
                padding: const EdgeInsets.all(10),
                child: AllianzButton(alert, 'Allianz Cup'),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(0),
                padding: const EdgeInsets.all(10),
                child: AdminButton(alert, 'Admin'),
              ),
            ]
          )
        )
      );
    }
    
  }
}

