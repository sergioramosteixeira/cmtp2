import 'package:flutter_application_1/data/clubes.dart';
import 'package:flutter_application_1/models/clube.dart';

class Jogo {
  int jogoId;
  String liga;
  DateTime dataJogo;
  String jornada;
  String estadio;
  String arbitro;
  Clube clubeCasa;
  Clube clubeFora;
  int golosCasa;
  int golosFora;

  Jogo({
    required this.jogoId,
    required this.liga,
    required this.dataJogo,
    required this.jornada,
    required this.estadio,
    required this.arbitro,
    required this.clubeCasa,
    required this.clubeFora,
    required this.golosCasa,
    required this.golosFora
  });

  

  

  factory Jogo.fromJson(dynamic json, Clube casa, Clube fora)  {
    return Jogo(
      jogoId: json['jogoId'],
      liga: json['liga'],
      dataJogo: DateTime.parse(json['dataJogo']),
      jornada: json['jornada'],
      estadio: json['estadio'],
      arbitro: json['arbitro'],
      clubeCasa: casa,
      clubeFora: fora,
      golosCasa: json['golosCasa'],
      golosFora: json['golosFora'],
    );
  }

  @override
  String toString() {
    return "${clubeCasa.sigla} - ${clubeFora.sigla}";
  }
  /*Fixture.fromJson(Map<String, dynamic> json) {
    fixtureId = json['fixture_id'];
    leagueId = json['league_id'];
    league =
    json['league'] != null ? new League.fromJson(json['league']) : null;
    eventDate = json['event_date'];
    eventTimestamp = json['event_timestamp'];
    firstHalfStart = json['firstHalfStart'];
    secondHalfStart = json['secondHalfStart'];
    round = json['round'];
    status = json['status'];
    statusShort = json['statusShort'];
    elapsed = json['elapsed'];
    venue = json['venue'];
    venue = json['referee'];
    homeTeam = json['homeTeam'] != null
        ? new HomeTeam.fromJson(json['homeTeam'])
        : null;
    awayTeam = json['awayTeam'] != null
        ? new HomeTeam.fromJson(json['awayTeam'])
        : null;
    goalsHomeTeam = json['goalsHomeTeam']??0;
    goalsAwayTeam = json['goalsAwayTeam']??0;
    score = json['score'] != null ? new Score.fromJson(json['score']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fixture_id'] = required this.fixtureId;
    data['league_id'] = required this.leagueId;
    if (required this.league != null) {
      data['league'] = required this.league.toJson();
    }
    data['event_date'] = required this.eventDate;
    data['event_timestamp'] = required this.eventTimestamp;
    data['firstHalfStart'] = required this.firstHalfStart;
    data['secondHalfStart'] = required this.secondHalfStart;
    data['round'] = required this.round;
    data['status'] = required this.status;
    data['statusShort'] = required this.statusShort;
    data['elapsed'] = required this.elapsed;
    data['venue'] = required this.venue;
    data['referee'] = required this.referee;
    if (required this.homeTeam != null) {
      data['homeTeam'] = required this.homeTeam.toJson();
    }
    if (required this.awayTeam != null) {
      data['awayTeam'] = required this.awayTeam.toJson();
    }
    data['goalsHomeTeam'] = required this.goalsHomeTeam;
    data['goalsAwayTeam'] = required this.goalsAwayTeam;
    if (required this.score != null) {
      data['score'] = required this.score.toJson();
    }
    return data;
  }
}

class League {
  String name;
  String country;
  String logo;
  String flag;

  League({required this.name, required this.country, required this.logo, required this.flag});

  League.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    country = json['country'];
    logo = json['logo'];
    flag = json['flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = required this.name;
    data['country'] = required this.country;
    data['logo'] = required this.logo;
    data['flag'] = required this.flag;
    return data;
  }
}

class HomeTeam {
  int teamId;
  String teamName;
  String logo;

  HomeTeam({required this.teamId, required this.teamName, required this.logo});

  HomeTeam.fromJson(Map<String, dynamic> json) {
    teamId = json['team_id'];
    teamName = json['team_name'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['team_id'] = required this.teamId;
    data['team_name'] = required this.teamName;
    data['logo'] = required this.logo;
    return data;
  }
}

class Score {
  String halftime;
  String fulltime;
  String extratime;
  String penalty;

  Score({required this.halftime, required this.fulltime, required this.extratime, required this.penalty});

  Score.fromJson(Map<String, dynamic> json) {
    halftime = json['halftime'];
    fulltime = json['fulltime'];
    extratime = json['extratime'];
    penalty = json['penalty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['halftime'] = required this.halftime;
    data['fulltime'] = required this.fulltime;
    data['extratime'] = required this.extratime;
    data['penalty'] = required this.penalty;
    return data;
  }*/
}
