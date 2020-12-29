import 'dart:math';
// Clase encargada de crear los parametros de una partida a partir de los datos de GameSettings
// Define la categoria y la palabra de la partida y la lista de jugadores/impostores

class ControllerLogic {

  final _random = new Random();

  int _numberOfPlayers = 5;
  int _numbersOfImpostors = 1;
  Map<int,int> _listOfCategories = {};
  bool _allImpostors = false;
  bool _noImpostors = false;
  bool _playOnThisDevice = false;

  bool isSelected(int category) => this._listOfCategories.containsKey(category);

  void setNumberOfPlayers(int numPlayers) => this._numberOfPlayers = numPlayers;

  void setNumberOfImpostors(int numImpostors) => this._numbersOfImpostors = numImpostors;

  void removeAllCategories() => this._listOfCategories = {};

  void editCategories(int category, int cantWords) {
    if(this._listOfCategories.containsKey(category)) {
      this._listOfCategories.remove(category);
    } else {
      this._listOfCategories.putIfAbsent(category, () => cantWords);
    }
  }

  void setAllImpostors() => this._allImpostors = !this._allImpostors;

  void setNoImpostors() => this._noImpostors = !this._noImpostors;

  void setPlayOnThisDevice() => this._playOnThisDevice = !this._playOnThisDevice;

  Map<String, dynamic> returnGame() {
    Map<String, dynamic> res = {};
    List<int> playersList = [];
    if(_listOfCategories.length > 0) {
      // Selecciono indice de categoria y una palabra de esa categoria
      int randomCategory = _listOfCategories.keys.elementAt(0 + _random.nextInt(_listOfCategories.length));
      int randomWord = 1 + _random.nextInt(_listOfCategories[randomCategory]);

      // Chequeos de opciones especiales
      if (_allImpostors && 1 + _random.nextInt(100) > 90) {
        playersList = List<int>.filled(_numberOfPlayers, -1, growable: true);
      }
      else if (_noImpostors && 1 + _random.nextInt(100) > 90) {
        playersList = List<int>.filled(_numberOfPlayers, 0, growable: true);
      }
      else { // Lista normal;
        for(int i = 0 ; i<_numbersOfImpostors; i++) playersList.add(-1);
        for(int i = 0 ; i<_numberOfPlayers - _numbersOfImpostors; i++) playersList.add(0);
        playersList.shuffle();
        print(playersList);
      }

      res.putIfAbsent('word', () => 'elem_'+randomWord.toString());
      res.putIfAbsent('category', () => 'topic_'+randomCategory.toString());
      res.putIfAbsent("players", () => playersList);
      res.putIfAbsent("playOnThisDevice", () => this._playOnThisDevice);
    }

    return res;
  }

}