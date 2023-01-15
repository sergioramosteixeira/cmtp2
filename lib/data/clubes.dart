import 'package:flutter_application_1/models/clube.dart';

class Clubes {
  Map <int, Clube> _clubes = <int, Clube>{};

  Map <int, Clube> get list => _clubes;

  void add(Clube clube) {
    int key = getMaxKey() + 1;
    _clubes.addEntries([MapEntry(key, clube)]);
  }

  int getMaxKey(){
    var thevalue=0;

    _clubes.keys.forEach((k){
      if(k>thevalue) {
        thevalue = k;
      }
    });

    return thevalue;
  }
}