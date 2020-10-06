
// Esta clase contiene mapeado la informacion de cada indice de categoria a informacion sobre ella
class GeneralParameters {
  // Por ejemplo: id = 1 corresponde a categoria: Animales, tiene dificultad: baja, tiene x posibles valores
  static const NUMBER_OF_CATEGORIES = 6;

  // TOPICO -> [DIFICULTAD_ARTISTAS, DIFICULTAD_IMPOSTOR]]
  // 1=facil, 2=medio, 3=dificil, 4=muy dificil, 5=imposible
  static const Map<int, List<int>> LEVELS_OF_DIFFICULTY = {
    1: [2,2],
    2: [2,2],
    3: [3,3],
    4: [2,5],
    5: [3,4],
    6: [1,1],
  };

  // id -> cantidad de palabras
  static const Map<int, int> NUMBER_OF_TOPIC_WORDS = {
    1: 10,
    2: 10,
    3: 12,
    4: 7,
    5: 15,
    6: 20
  };

}