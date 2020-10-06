import 'package:faux_artista_the_game/controller/controller_logic.dart';
import 'package:faux_artista_the_game/controller/general_parameters.dart';
import 'package:faux_artista_the_game/locale/app_localization.dart';
import 'package:flutter/material.dart';

class CustomTile extends StatefulWidget {
  final int _id;
  final ControllerLogic _controller;
  final dynamic _notifyParentFunction;
  CustomTile({int id, ControllerLogic controller, dynamic notifyParentFunction}) : this._id = id, this._controller = controller, this._notifyParentFunction = notifyParentFunction;

  int getId() => this._id;

  ControllerLogic getController() => this._controller;

  dynamic getNotifyParentFunction() => this._notifyParentFunction;

  @override
  CustomTileState createState() => CustomTileState();
}

class CustomTileState extends State<CustomTile> {
  Color color, selectedColor, artistDificultyFontColor, impostorDificultyFontColor;
  bool _selected;

  @override
  void initState() {
    super.initState();
    color = Colors.transparent;
    selectedColor = Colors.blue[200];
    _selected = false;
  }

  @override
  Widget build(BuildContext context) {
    // Ejemplo de palabra de la categoria
    String example =  AppLocalization.of(context).translate("game_settings_example_label")
        + AppLocalization.of(context).translateTopic("topic_"+widget.getId().toString(), 'example');
    List<int> difficulty = GeneralParameters.LEVELS_OF_DIFFICULTY[widget.getId()];
    _setColors(difficulty);
    
    return Container(
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: Colors.black,
          width: 0.3,
        ),
      ),
      child: InkWell(
        onTap: () {
          // Llamo funcion en el padre para modificar color de comenzar
          widget.getNotifyParentFunction()(widget.getId());
          _selected = !_selected;
          // Al tocar, guardo el id en la lista de categorias a sortear
          widget.getController().editCategories(widget.getId());
          setState(() {
            _selected == true
                ? color = selectedColor
                : color = Colors.transparent;
          });
        },
        child: ListTile(
          title: RichText(
              text: TextSpan(
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w500
                ),
                children: <TextSpan>[
                  TextSpan(text: AppLocalization.of(context).translateTopic("topic_"+widget.getId().toString(), 'title')),
                  TextSpan(text: "   "),
                  TextSpan(text: "["+ GeneralParameters.NUMBER_OF_TOPIC_WORDS[widget.getId()].toString() +"]",
                    style: TextStyle(fontSize: 12)
                  )
                ]
              )
          ),
          subtitle: RichText(
            text: TextSpan(
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 13
              ),
              children: <TextSpan>[
                TextSpan(text: AppLocalization.of(context).translate("game_settings_difficulty_label_artists") + ": "),
                TextSpan(text: AppLocalization.of(context).translate("game_settings_difficulty_"+difficulty[0].toString()) + "\n", style: TextStyle(fontWeight: FontWeight.bold, color: artistDificultyFontColor)),
                TextSpan(text: AppLocalization.of(context).translate("game_settings_difficulty_label_impostor") + ": "),
                TextSpan(text: AppLocalization.of(context).translate("game_settings_difficulty_"+difficulty[1].toString()) + "\n", style: TextStyle(fontWeight: FontWeight.bold, color: impostorDificultyFontColor)),
                TextSpan(text: example , style: TextStyle(color: Colors.black54)),
              ]
            )
          )
        ),
      ),
    );
  }

  void _setColors(List<int> difficulty) {
    switch(difficulty[0]){
      case 1: {
        artistDificultyFontColor = Colors.green;
      } break;
      case 2: {
        artistDificultyFontColor = Colors.amber;
      } break;
      case 3: {
        artistDificultyFontColor = Colors.red;
      } break;
      case 4: {
        artistDificultyFontColor = Colors.deepPurple;
      } break;
      case 5: {
        selectedColor = Colors.black54;
        artistDificultyFontColor = Colors.black;
      } break;
    }
    switch(difficulty[1]){
      case 1: {
        impostorDificultyFontColor = Colors.green;
      } break;
      case 2: {
        impostorDificultyFontColor = Colors.amber;
      } break;
      case 3: {
        impostorDificultyFontColor = Colors.red;
      } break;
      case 4: {
        impostorDificultyFontColor = Colors.deepPurple;
      } break;
      case 5: {
        impostorDificultyFontColor = Colors.black;
      } break;
    }
  }
}