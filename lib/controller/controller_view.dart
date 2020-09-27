import 'package:faux_artista_the_game/controller/general_parameters.dart';
import 'package:faux_artista_the_game/widgets/custom_tile.dart';
import 'package:flutter/material.dart';

class ControllerView {
  // Retorna una lista con botones para las categorias en el menu de opciones del juego
  ListView getCategoryList(BuildContext context) {
     List listings = List<Widget>();
     for(var i = 1; i<=GeneralParameters.NUMBER_OF_CATEGORIES; i++){
       listings.add(
         CustomTile(id: i)
       );
     }
     return ListView(
       scrollDirection: Axis.vertical,
       shrinkWrap: true,
       children: listings,
     );
  }
}
