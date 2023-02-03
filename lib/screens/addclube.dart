import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/data/clubes.dart';
import 'package:flutter_application_1/models/clube.dart';
import 'package:flutter_application_1/screens/clubesinscritos.dart';
import 'package:flutter_application_1/screens/mainmenu.dart';
import 'package:flutter_application_1/widgets/defaultappbar.dart';

class AddClube extends StatefulWidget{
  //Screen de adicionar ou editar clubes

  static final String routeName = '/addclube'; //Rota
  final String? clube;   //Se o parâmetro clube for nulo, é um clube novo. Caso contrário, é uma edição
  AddClube({this.clube});

  @override
  State<AddClube> createState() => _AddClubeState();
}

class _AddClubeState extends State<AddClube> {
  
  final Clubes _clubes = Clubes();

  final nome = TextEditingController();
  final sigla = TextEditingController();
  final logo = TextEditingController();
  final fundado = TextEditingController();
  final pais = TextEditingController();
  final nomeEstadio = TextEditingController();
  final moradaEstadio = TextEditingController();
  final cidadeEstadio = TextEditingController();
  final capacidadeEstadio = TextEditingController();

  String textButton = "Adicionar Clube";

  @override
  void initState() {
    super.initState();

    if(widget.clube != null){
        //Se houver parâmetro de clube, os campos são preenchidos automaticamente
        updateClube();
    }    
  }

  @override
  void updateClube() async {
    //Se houver parâmetro de clube, os campos são preenchidos automaticamente
    await _clubes.getClubes();
    Clube clube = _clubes.getClubeBySigla(widget.clube!);
    nome.text=clube.nome;
    sigla.text=clube.sigla;
    logo.text=clube.logo;
    fundado.text=clube.fundado.toString();
    pais.text=clube.pais;
    nomeEstadio.text=clube.nomeEstadio;
    moradaEstadio.text=clube.moradaEstadio;
    cidadeEstadio.text=clube.cidadeEstadio;
    capacidadeEstadio.text=clube.capacidadeEstadio.toString();
    textButton = "Alterar Clube";
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
                controller: nome,
                decoration: const InputDecoration(
                  labelText: "Nome do Clube",
                ),
                keyboardType: TextInputType.text,
              ),
              TextField(
                enabled: (widget.clube==null) ? true : false,
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
                  //Inscrição / Alteração no Firestore
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
                  //Se for novo clube, vai para a página de inscrição de clubes em competições
                  //Se for edição de clube, retorna duas páginas
                  if(widget.clube==null) {
                    Navigator.pushNamed(context, ClubesInscritos.routeName);
                    ClubesInscritos(); 
                  }else{
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }
                  
                },
                //Estilo do Botão de confirmação
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