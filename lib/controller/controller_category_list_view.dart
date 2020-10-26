import 'dart:math';

import '../controller/controller_logic.dart';
import '../locale/app_localization.dart';
import '../widgets/game_settings_widgets/custom_ad_tile.dart';
import '../widgets/game_settings_widgets/custom_tile.dart';
import '../widgets/game_settings_widgets/search_banner.dart';
import 'package:flutter/material.dart';

class ControllerCategoryListView {
  final _random = new Random();

  // Returns list of buttons for the categories in the optiones menu of the game
  ScrollConfiguration getCategoryList(
      BuildContext context,
      ControllerLogic controllerLogic,
      Function changeBeginButtonColor,
      Function handleAdButton,
      Function handleSearch,
      String filterSearch,
      bool showSecretCategory
      ) {
    List listings = List<Widget>();

    // Search tool
    listings.add(
        SearchBanner(notifyFunction: handleSearch)
    );

    // Load category cards
    if (filterSearch == '') {
      for(var i = 1; i<=int.parse(AppLocalization.of(context).translate("number_of_categories")); i++){
        listings.add(
            CustomTile(id: i, controller: controllerLogic, notifyParentFunction: changeBeginButtonColor)
        );
      }
    } else { // here the categories are filtered by filterSearch
      List<int> idCategoriesFiltered = _categoryFilterFunction(context, filterSearch);
      for(var i = 0; i<idCategoriesFiltered.length; i++){
        listings.add(
            CustomTile(id: idCategoriesFiltered[i], controller: controllerLogic, notifyParentFunction: changeBeginButtonColor)
        );
      }
    }

    // If wanted, add secret category
    if (showSecretCategory) {
      int secretCategoryId = 100 + (1 + _random.nextInt(2)); // Secret categories are 11, 12, 13 ....
      listings.add(
          CustomTile(id: secretCategoryId, controller: controllerLogic, notifyParentFunction: changeBeginButtonColor)
      );
    } else {
      // Ad Button
      listings.add(
          CustomAdTile(notifyParentFunction: handleAdButton)
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

  // Search categories with 'filterSearch' title and returns a list with theirs ids
  List<int> _categoryFilterFunction(BuildContext context, String filterSearch) {
    List<int> res = [];
    for(var i = 1; i<=int.parse(AppLocalization.of(context).translate("number_of_categories")); i++){
      // If the search text is contained in some topic title -> add to result
      if(AppLocalization.of(context).translateTopic("topic_${i.toString()}", "title").toLowerCase().contains(filterSearch.toLowerCase())) {
        res.add(i);
      }
    }
    return res;
  }
}
