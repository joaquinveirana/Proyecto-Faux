import 'package:faux_artista_the_game/controller/controller_logic.dart';
import 'package:faux_artista_the_game/controller/general_parameters.dart';
import 'package:faux_artista_the_game/widgets/custom_tile.dart';
import 'package:flutter/material.dart';

class ControllerView {
  // Retorna una lista con botones para las categorias en el menu de opciones del juego
  ScrollConfiguration getCategoryList(BuildContext context, ControllerLogic controllerLogic, dynamic changeBeginButtonColor) {
     List listings = List<Widget>();
     for(var i = 1; i<=GeneralParameters.NUMBER_OF_CATEGORIES; i++){
       listings.add(
         CustomTile(id: i, controller: controllerLogic, notifyParentFunction: changeBeginButtonColor)
       );
     }
     return ScrollConfiguration(
       behavior: ScrollBehavior(),
       child: GlowingOverscrollIndicator(
         axisDirection: AxisDirection.down,
         color: Colors.deepPurple[100],
         child: ListView(
           scrollDirection: Axis.vertical,
           shrinkWrap: true,
           children: listings,
         ),
       ),
     );
  }
}
