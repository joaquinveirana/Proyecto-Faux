import 'package:faux_the_game/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomTileFunctions {

  Color setColors(String difficulty) {
    switch(difficulty){
      case '1': {
        return Colors.green;
      } break;
      case '2': {
        return Colors.orange;
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

  IconButton setIcon(BuildContext context, String topic) {
    if (AppLocalization.of(context).locale == Locale("en","US")) {
      switch(topic){
        case '1': {
          return IconButton(
              onPressed: (){},
              iconSize: 40,
              color: Colors.black87,
              icon: FaIcon(FontAwesomeIcons.lightbulb)
          );
        } break;
        case '2': {
          return IconButton(
              onPressed: (){},
              iconSize: 40,
              color: Colors.black87,
              icon: FaIcon(FontAwesomeIcons.paw)
          );
        } break;
        case '3': {
          return IconButton(
              onPressed: (){},
              iconSize: 40,
              color: Colors.black87,
              icon: FaIcon(FontAwesomeIcons.circle)
          );
        } break;
        case '4': {
          return IconButton(
              onPressed: (){},
              iconSize: 40,
              color: Colors.black87,
              icon: FaIcon(FontAwesomeIcons.building)
          );
        } break;
        case '5': {
          return IconButton(
              onPressed: (){},
              iconSize: 40,
              color: Colors.black87,
              icon: FaIcon(FontAwesomeIcons.city)
          );
        } break;
        case '6': {
          return IconButton(
              onPressed: (){},
              iconSize: 40,
              color: Colors.black87,
              icon: FaIcon(FontAwesomeIcons.film)
          );
        } break;
        case '7': {
          return IconButton(
              onPressed: (){},
              iconSize: 40,
              color: Colors.black87,
              icon: FaIcon(FontAwesomeIcons.gamepad)
          );
        } break;
        case '8': {
          return IconButton(
              onPressed: (){},
              iconSize: 40,
              color: Colors.black87,
              icon: FaIcon(FontAwesomeIcons.atom)
          );
        } break;
        case '9': {
          return IconButton(
              onPressed: (){},
              iconSize: 40,
              color: Colors.black87,
              icon: FaIcon(FontAwesomeIcons.flag)
          );
        } break;
        case '10': {
          return IconButton(
              onPressed: (){},
              iconSize: 40,
              color: Colors.black87,
              icon: FaIcon(FontAwesomeIcons.film)
          );
        } break;
        case '11': {
          return IconButton(
              onPressed: (){},
              iconSize: 40,
              color: Colors.black87,
              icon: FaIcon(FontAwesomeIcons.hamburger)
          );
        } break;
        case '12': {
          return IconButton(
              onPressed: (){},
              iconSize: 40,
              color: Colors.black87,
              icon: FaIcon(FontAwesomeIcons.pastafarianism)
          );
        } break;
        case '13': {
          return IconButton(
              onPressed: (){},
              iconSize: 35,
              color: Colors.black87,
              icon: FaIcon(FontAwesomeIcons.home)
          );
        } break;
        case '14': {
          return IconButton(
              onPressed: (){},
              iconSize: 35,
              color: Colors.black87,
              icon: FaIcon(FontAwesomeIcons.arrowsAltH)
          );
        } break;
        case '15': {
          return IconButton(
              onPressed: (){},
              iconSize: 35,
              color: Colors.black87,
              icon: FaIcon(FontAwesomeIcons.basketballBall)
          );
        } break;
        case '16': {
          return IconButton(
              onPressed: (){},
              iconSize: 35,
              color: Colors.black87,
              icon: FaIcon(FontAwesomeIcons.mask)
          );
        } break;
        case '17': {
          return IconButton(
              onPressed: (){},
              iconSize: 35,
              color: Colors.black87,
              icon: FaIcon(FontAwesomeIcons.gamepad)
          );
        } break;
        case '101': {
          return IconButton(
              onPressed: (){},
              iconSize: 40,
              color: Colors.black87,
              icon: FaIcon(FontAwesomeIcons.hatCowboy)
          );
        } break;
        case '102': {
          return IconButton(
              onPressed: (){},
              iconSize: 40,
              color: Colors.black87,
              icon: FaIcon(FontAwesomeIcons.bomb)
          );
        } break;
        case '103': {
          return IconButton(
              onPressed: (){},
              iconSize: 40,
              color: Colors.black87,
              icon: FaIcon(FontAwesomeIcons.film)
          );
        } break;
        case '104': {
          return IconButton(
              onPressed: (){},
              iconSize: 40,
              color: Colors.black87,
              icon: FaIcon(FontAwesomeIcons.film)
          );
        } break;
        case '105': {
          return IconButton(
              onPressed: (){},
              iconSize: 40,
              color: Colors.black87,
              icon: FaIcon(FontAwesomeIcons.bug)
          );
        } break;
        case '106': {
          return IconButton(
              onPressed: (){},
              iconSize: 40,
              color: Colors.black87,
              icon: FaIcon(FontAwesomeIcons.meh)
          );
        } break;
      }
    } else {
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
              icon: FaIcon(FontAwesomeIcons.circle)
          );
        } break;
        case '3': {
          return IconButton(
              onPressed: (){},
              iconSize: 40,
              color: Colors.black87,
              icon: FaIcon(FontAwesomeIcons.city)
          );
        } break;
        case '4': {
          return IconButton(
              onPressed: (){},
              iconSize: 40,
              color: Colors.black87,
              icon: FaIcon(FontAwesomeIcons.hamburger)
          );
        } break;
        case '5': {
          return IconButton(
              onPressed: (){},
              iconSize: 40,
              color: Colors.black87,
              icon: FaIcon(FontAwesomeIcons.lightbulb)
          );
        } break;
        case '6': {
          return IconButton(
              onPressed: (){},
              iconSize: 40,
              color: Colors.black87,
              icon: FaIcon(FontAwesomeIcons.basketballBall)
          );
        } break;
        case '7': {
          return IconButton(
              onPressed: (){},
              iconSize: 40,
              color: Colors.black87,
              icon: FaIcon(FontAwesomeIcons.building)
          );
        } break;
        case '8': {
          return IconButton(
              onPressed: (){},
              iconSize: 40,
              color: Colors.black87,
              icon: FaIcon(FontAwesomeIcons.atom)
          );
        } break;
        case '9': {
          return IconButton(
              onPressed: (){},
              iconSize: 40,
              color: Colors.black87,
              icon: FaIcon(FontAwesomeIcons.pastafarianism)
          );
        } break;
        case '10': {
          return IconButton(
              onPressed: (){},
              iconSize: 40,
              color: Colors.black87,
              icon: FaIcon(FontAwesomeIcons.home)
          );
        } break;
        case '11': {
          return IconButton(
              onPressed: (){},
              iconSize: 40,
              color: Colors.black87,
              icon: FaIcon(FontAwesomeIcons.arrowsAltH)
          );
        } break;
        case '12': {
          return IconButton(
              onPressed: (){},
              iconSize: 40,
              color: Colors.black87,
              icon: FaIcon(FontAwesomeIcons.flag)
          );
        } break;
        case '13': {
          return IconButton(
              onPressed: (){},
              iconSize: 35,
              color: Colors.black87,
              icon: FaIcon(FontAwesomeIcons.film)
          );
        } break;
        case '14': {
          return IconButton(
              onPressed: (){},
              iconSize: 35,
              color: Colors.black87,
              icon: FaIcon(FontAwesomeIcons.gamepad)
          );
        } break;
        case '15': {
          return IconButton(
              onPressed: (){},
              iconSize: 35,
              color: Colors.black87,
              icon: FaIcon(FontAwesomeIcons.film)
          );
        } break;
        case '16': {
          return IconButton(
              onPressed: (){},
              iconSize: 35,
              color: Colors.black87,
              icon: FaIcon(FontAwesomeIcons.mask)
          );
        } break;
        case '17': {
          return IconButton(
              onPressed: (){},
              iconSize: 35,
              color: Colors.black87,
              icon: FaIcon(FontAwesomeIcons.gamepad)
          );
        } break;
        case '101': {
          return IconButton(
              onPressed: (){},
              iconSize: 40,
              color: Colors.black87,
              icon: FaIcon(FontAwesomeIcons.hatCowboy)
          );
        } break;
        case '102': {
          return IconButton(
              onPressed: (){},
              iconSize: 40,
              color: Colors.black87,
              icon: FaIcon(FontAwesomeIcons.bomb)
          );
        } break;
        case '103': {
          return IconButton(
              onPressed: (){},
              iconSize: 40,
              color: Colors.black87,
              icon: FaIcon(FontAwesomeIcons.film)
          );
        } break;
        case '104': {
          return IconButton(
              onPressed: (){},
              iconSize: 40,
              color: Colors.black87,
              icon: FaIcon(FontAwesomeIcons.film)
          );
        } break;
        case '105': {
          return IconButton(
              onPressed: (){},
              iconSize: 40,
              color: Colors.black87,
              icon: FaIcon(FontAwesomeIcons.bug)
          );
        } break;
        case '106': {
          return IconButton(
              onPressed: (){},
              iconSize: 40,
              color: Colors.black87,
              icon: FaIcon(FontAwesomeIcons.meh)
          );
        } break;
      }
    }
    return null;
  }

}