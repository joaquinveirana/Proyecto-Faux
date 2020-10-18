import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomTileFunctions {

  Color setColors(String difficulty) {
    switch(difficulty){
      case '1': {
        return Colors.green;
      } break;
      case '2': {
        return Colors.yellow;
      } break;
      case '3': {
        return Colors.red;
      } break;
      case '4': {
        return Colors.deepPurple;
      } break;
      case '5': {
        return Colors.black;
      } break;
    }
    return null;
  }

  IconButton setIcon(String topic) {
    switch(topic){
      case '1': {
        return IconButton(
            onPressed: (){},
            iconSize: 40,
            color: Colors.black87,
            icon: FaIcon(FontAwesomeIcons.paw)
        );
      } break;
      case '2': {
        return IconButton(
            onPressed: (){},
            iconSize: 40,
            color: Colors.black87,
            icon: FaIcon(FontAwesomeIcons.mask)
        );
      } break;
      case '3': {
        return IconButton(
            onPressed: (){},
            iconSize: 40,
            color: Colors.black87,
            icon: FaIcon(FontAwesomeIcons.home)
        );
      } break;
      case '4': {
        return IconButton(
            onPressed: (){},
            iconSize: 40,
            color: Colors.black87,
            icon: FaIcon(FontAwesomeIcons.lightbulb)
        );
      } break;
      case '5': {
        return IconButton(
            onPressed: (){},
            iconSize: 40,
            color: Colors.black87,
            icon: FaIcon(FontAwesomeIcons.pastafarianism)
        );
      } break;
      case '6': {
        return IconButton(
            onPressed: (){},
            iconSize: 40,
            color: Colors.black87,
            icon: FaIcon(FontAwesomeIcons.building)
        );
      } break;
    }
    return null;
  }

}