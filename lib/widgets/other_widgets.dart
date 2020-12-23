import 'package:flutter/material.dart';

class OtherWidgets {
  Container backButton(BuildContext context, int countPop) {
    return Container(
      child: InkWell(
          onTap: () {
            int counter = 0;
            Navigator.of(context).popUntil((_) => counter++ >= countPop);
          },
          child: Icon(Icons.keyboard_arrow_left, color: Colors.black, size: 25,)
      ),
    );
  }

  Container helpButton(BuildContext context) {
    return Container(
      child: InkWell(
          onTap: () => {print("TODO Mostrar Ayuda")},
          child: Icon(Icons.help, color: Colors.black, size: 25,)
      ),
    );
  }
}