
// Esta clase contiene mapeado la informacion de cada indice de categoria a informacion sobre ella
class GeneralParameters {
  // Por ejemplo: id = 1 corresponde a categoria: Animales, tiene dificultad: baja, tiene x posibles valores
  static const NUMBER_OF_CATEGORIES = 4;

  // TOPICO -> [DIFICULTAD_ARTISTAS, DIFICULTAD_IMPOSTOR]]
  // 1=facil, 2=medio, 3=dificil, 4=muy dificil, 5=imposible
  static const Map<int, List<int>> LEVELS_OF_DIFFICULTY = {
    1: [2,1],
    2: [2,2],
    3: [3,1],
    4: [5,5]
  };

  // id -> cantidad de palabras
  static const Map<int, int> NUMBER_OF_TOPIC_WORDS = {
    1: 10,
    2: 10,
    3: 12,
    4: 5
  };

}