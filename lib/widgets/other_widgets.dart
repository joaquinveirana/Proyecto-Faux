import 'package:flutter/material.dart';

class OtherWidgets {
  Container backButton(BuildContext context) {
    return Container(
      child: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.keyboard_arrow_left, color: Colors.black, size: 25,)
      ),
    );
  }
}