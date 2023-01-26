import 'package:flutter/material.dart';

class Clube {
  //int clubeId;
  String nome;
  String sigla;
  String logo;
  String pais;
  int fundado;
  String nomeEstadio;
  String moradaEstadio;
  String cidadeEstadio;
  int capacidadeEstadio;

  Clube({
      //required this.clubeId,
      required this.nome,
      required this.sigla,
      required this.logo,
      required this.pais,
      required this.fundado,
      required this.nomeEstadio,
      required this.moradaEstadio,
      required this.cidadeEstadio,
      required this.capacidadeEstadio});

  factory Clube.fromJson(dynamic json) {
    return Clube(
      //clubeId: json['clubeId'],
      nome: json['nome'],
      sigla: json['sigla'],
      logo: json['logo'],
      pais: json['pais'],
      fundado: json['fundado'],
      nomeEstadio: json['nomeEstadio'],
      moradaEstadio: json['moradaEstadio'],
      cidadeEstadio: json['cidadeEstadio'],
      capacidadeEstadio: json['capacidadeEstadio'],
    );
  }

  
  /*Clube.fromJson(Map<String, dynamic> json) {
    clubeId = json['clube_Id'];
    nome = json['nome'];
    sigla = json['sigla'];
    logo = json['logo'];
    pais = json['pais'];
    fundado = json['fundado'];
    nomeEstadio = json['nomeEstadio'];
    moradaEstadio = json['moradaEstadio'];
    cidadeEstadio = json['cidadeEstadio'];
    capacidadeEstadio = json['capacidadeEstadio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clube_Id'] = this.clubeId;
    data['nome'] = this.nome;
    data['sigla'] = this.sigla;
    data['logo'] = this.logo;
    data['pais'] = this.pais;
    data['fundado'] = this.fundado;
    data['nomeEstadio'] = this.nomeEstadio;
    data['moradaEstadio'] = this.moradaEstadio;
    data['venue_address'] = this.cidadeEstadio;
    data['capacidadeEstadio'] = this.capacidadeEstadio;
    return data;
  }*/

  @override
  String toString() {
    return sigla;
  }
}
