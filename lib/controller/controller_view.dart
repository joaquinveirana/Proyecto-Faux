import '../controller/controller_logic.dart';
import '../controller/general_parameters.dart';
import '../widgets/game_settings_widgets/custom_ad_tile.dart';
import '../widgets/game_settings_widgets/custom_tile.dart';
import '../widgets/game_settings_widgets/search_banner.dart';
import 'package:flutter/material.dart';

class ControllerView {
  // Returns list of buttons for the categories in the optiones menu of the game
  ScrollConfiguration getCategoryList(
      ControllerLogic controllerLogic,
      Function changeBeginButtonColor,
      Function handleAdButton,
      Function handleSearch,
      String filterSearch
      ) {
     List listings = List<Widget>();

     // Search tool
     listings.add(
         SearchBanner(notifyFunction: handleSearch)
     );

     // Load category cards
     if (filterSearch == '') {
       for(var i = 1; i<=GeneralParameters.NUMBER_OF_CATEGORIES; i++){
         listings.add(
             CustomTile(id: i, controller: controllerLogic, notifyParentFunction: changeBeginButtonColor)
         );
       }
     } else { // here the categories are filtered
       List<int> categoriesFiltered = _categoryFilterFunction(filterSearch);
       for(var i = 1; i<=categoriesFiltered.length; i++){
         listings.add(
             CustomTile(id: categoriesFiltered[i], controller: controllerLogic, notifyParentFunction: changeBeginButtonColor)
         );
       }
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

  // Search categories with 'filterSearch' name and returns a list with theirs ids
  List<int> _categoryFilterFunction(String filterSearch) {
    return [];
    // TODO
  }
}
