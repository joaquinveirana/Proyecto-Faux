import 'dart:math';

import 'package:faux_artista_the_game/controller/general_parameters.dart';

// Clase encargada de crear los parametros de una partida a partir de los datos de GameSettings
// Define la categoria y la palabra de la partida y la lista de jugadores/impostores

class ControllerLogic {

  final _random = new Random();

  int _numberOfPlayers = 5;
  int _numbersOfImpostors = 1;
  List<int> _listOfCategories = [];
  bool _allImpostors = false;
  bool _noImpostors = false;

  void setNumberOfPlayers(int numPlayers) {
    this._numberOfPlayers = numPlayers;
  }

  void setNumberOfImpostors(int numImpostors) {
    this._numbersOfImpostors = numImpostors;
  }

  void editCategories(int cat) {
    if(this._listOfCategories.contains(cat)) {
      this._listOfCategories.remove(cat);
    } else {
      this._listOfCategories.add(cat);
    }
  }

  void setAllImpostors(){
    bool newVal = !this._allImpostors;
    this._allImpostors = newVal;
  }

  void setNoImpostors(){
    this._noImpostors = !this._noImpostors;
  }

  Map<String, dynamic> returnGame() {

    Map<String, dynamic> res = {};
    if(_listOfCategories.length > 0) {
      // Defino la categoria y la palabra de esa categoria
      // Selecciono indice al azar de la lista de categorias marcadas
      int randomIndexCategory = 0 + _random.nextInt(_listOfCategories.length);
      // Selecciono indice de palabra aleatoria en la categoria
      int randomWord = 1 + _random.nextInt(GeneralParameters.NUMBER_OF_TOPIC_WORDS[_listOfCategories[randomIndexCategory]]);
      res.putIfAbsent('word', () => 'elem_'+randomWord.toString());
      res.putIfAbsent('category', () => 'topic_'+_listOfCategories[randomIndexCategory].toString());



      // Defino los jugadores y las opciones especiales
      var players = List<int>.filled(_numberOfPlayers, 0, growable: true);
      // Sorteo si decido aplicar las opciones especiales
      int randomSpecialOption = 0 + _random.nextInt(100);
      if (_allImpostors == true && randomSpecialOption >= 90) { // 5% TODOS IMPOSTORES
        for(var i=0; i<this._numberOfPlayers; i++) {
          players[i] = -1;
        }
      } else if (_noImpostors == true && randomSpecialOption >= 90) { // 5% SIN IMPOSTORES
        for(var i=0; i<this._numberOfPlayers; i++) {
          players[i] = 0;
        }
      } else { // Genero lista normal
        for(var i=0; i<_numbersOfImpostors; i++) {
          players[0 + _random.nextInt(_numberOfPlayers)] = -1;
        }
      }
      res.putIfAbsent("players", () => players);
    }
    return res;
  }

}