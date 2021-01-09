import 'package:flutter/material.dart';
import '../../styles/colors.dart';
import '../../controller/controller_logic.dart';
import '../../styles/fonts.dart';
import '../../locale/app_localization.dart';
import '../../functions/custom_tile_functions.dart';

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
  final AppColors _colors = AppColors();
  Color selectedColor, artistDificultyFontColor, impostorDificultyFontColor;
  bool _selected;
  LinearGradient color, selectedGradientColor, unselectedGradientColor;

  @override
  void initState() {
    super.initState();
    selectedGradientColor = _colors.gameSettingsSelectedButtonGradient();
    unselectedGradientColor = _colors.gameSettingsUnselectedButtonGradient();
    color = unselectedGradientColor;
    selectedColor = Colors.blue[200];
    _selected = widget.getController().isSelected(widget.getId());
  }

  @override
  Widget build(BuildContext context) {
    // Parametros de la card de categoria (dificultad, ejemplo, cant palabras)
    String example =  AppLocalization.of(context).translate("game_settings_example_label")
        + AppLocalization.of(context).translateTopic("topic_"+widget.getId().toString(), 'example');
    String artistDifficulty = AppLocalization.of(context).translateTopic("topic_"+widget.getId().toString(), 'artistDifficulty');
    String impostorDifficulty = AppLocalization.of(context).translateTopic("topic_"+widget.getId().toString(), 'impostorDifficulty');
    String numWords = AppLocalization.of(context).translateTopic("topic_"+widget.getId().toString(), 'cantOfWords');
    artistDificultyFontColor = _functions.setColors(artistDifficulty);
    impostorDificultyFontColor = _functions.setColors(impostorDifficulty);
    
    return Container(
      margin: EdgeInsets.only(top: 7, left: 10, right: 10),
      decoration: BoxDecoration(
        gradient: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0.7,
            blurRadius: 1,
            offset: _selected
                ? Offset(0, 0)
                : Offset(2, 2),
        )]
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: () {
            // Llamo funcion en el padre para modificar color de comenzar
            widget.getNotifyParentFunction()(widget.getId());
            _selected = !_selected;
            // Al tocar, guardo el id en la lista de categorias a sortear
            widget.getController().editCategories(widget.getId(), int.parse(AppLocalization.of(context).translateTopic("topic_"+widget.getId().toString(), 'cantOfWords')));
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
                    TextSpan(text: " "),
                    TextSpan(text: "["+ numWords +"]",
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
                  TextSpan(text: AppLocalization.of(context).translate("game_settings_difficulty_"+artistDifficulty) + "\n", style: _fontStyles.openSansBold(14, artistDificultyFontColor)),
                  TextSpan(text: AppLocalization.of(context).translate("game_settings_difficulty_label_impostor") + ": "),
                  TextSpan(text: AppLocalization.of(context).translate("game_settings_difficulty_"+impostorDifficulty) + "\n", style: _fontStyles.openSansBold(14, impostorDificultyFontColor)),
                  TextSpan(text: example , style: _fontStyles.openSans(13, Colors.grey[700])),
                ]
              )
            ),
            trailing: _functions.setIcon(context, widget.getId().toString()),
          ),
        ),
      ),
    );
  }
}