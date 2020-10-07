import '../controller/controller_logic.dart';
import '../controller/general_parameters.dart';
import '../fonts/styles.dart';
import '../locale/app_localization.dart';
import '../functions/custom_tile_functions.dart';
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
  final FontStyles _fontStyles = FontStyles();
  final CustomTileFunctions _functions = CustomTileFunctions();
  Color selectedColor, artistDificultyFontColor, impostorDificultyFontColor;
  bool _selected;

  LinearGradient color;
  LinearGradient selectedGradientColor = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [Color(0xff19c5ff), Color(0xff33A3fC)]);
  LinearGradient unselectedGradientColor = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.centerRight,
      colors: [Color(0xffc7c8d0), Color(0xffcacbd3)]);

  @override
  void initState() {
    super.initState();
    color = unselectedGradientColor;
    selectedColor = Colors.blue[200];
    _selected = false;
  }

  @override
  Widget build(BuildContext context) {
    // Ejemplo de palabra de la categoria
    String example =  AppLocalization.of(context).translate("game_settings_example_label")
        + AppLocalization.of(context).translateTopic("topic_"+widget.getId().toString(), 'example');
    List<int> difficulty = GeneralParameters.LEVELS_OF_DIFFICULTY[widget.getId()];
    artistDificultyFontColor = _functions.setColors(difficulty[0]);
    impostorDificultyFontColor = _functions.setColors(difficulty[1]);
    
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: color,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 3,
            offset: Offset(2, 2), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(8)
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: () {
            // Llamo funcion en el padre para modificar color de comenzar
            widget.getNotifyParentFunction()(widget.getId());
            _selected = !_selected;
            // Al tocar, guardo el id en la lista de categorias a sortear
            widget.getController().editCategories(widget.getId());
            setState(() {
              _selected == true
                  ? color = selectedGradientColor
                  : color = unselectedGradientColor;
            });
          },
          child: ListTile(
            title: RichText(
                text: TextSpan(
                  style: _fontStyles.openSansSemiBold(20, Colors.black),
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
                style: _fontStyles.openSans(13, Colors.black),
                children: <TextSpan>[
                  TextSpan(text: AppLocalization.of(context).translate("game_settings_difficulty_label_artists") + ": "),
                  TextSpan(text: AppLocalization.of(context).translate("game_settings_difficulty_"+difficulty[0].toString()) + "\n", style: _fontStyles.openSansBold(14, artistDificultyFontColor)),
                  TextSpan(text: AppLocalization.of(context).translate("game_settings_difficulty_label_impostor") + ": "),
                  TextSpan(text: AppLocalization.of(context).translate("game_settings_difficulty_"+difficulty[1].toString()) + "\n", style: _fontStyles.openSansBold(14, impostorDificultyFontColor)),
                  TextSpan(text: example , style: _fontStyles.openSans(13, Colors.grey[700])),
                ]
              )
            ),
            trailing: _functions.setIcon(widget.getId().toString()),
          ),
        ),
      ),
    );
  }


}