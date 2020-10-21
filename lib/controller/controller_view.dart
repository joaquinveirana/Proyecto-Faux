import '../controller/controller_logic.dart';
import '../controller/general_parameters.dart';
import '../widgets/game_settings_widgets/custom_ad_tile.dart';
import '../widgets/game_settings_widgets/custom_tile.dart';
import 'package:flutter/material.dart';

class ControllerView {
  // Retorna una lista con botones para las categorias en el menu de opciones del juego
  ScrollConfiguration getCategoryList(ControllerLogic controllerLogic, dynamic changeBeginButtonColor, dynamic handleAdButton) {
     List listings = List<Widget>();

     // Load category cards
     for(var i = 1; i<=GeneralParameters.NUMBER_OF_CATEGORIES; i++){
       listings.add(
         CustomTile(id: i, controller: controllerLogic, notifyParentFunction: changeBeginButtonColor)
       );
     }

     // If wanted, add secret category

     // Ad Button
     listings.add(
         CustomAdTile(notifyParentFunction: handleAdButton)
     );

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
