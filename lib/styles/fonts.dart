import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FontStyles {
  TextStyle abrilFatface(double size) {
    return GoogleFonts.abrilFatface(
      fontSize: size,
      color: Colors.white
    );
  }

  TextStyle dancingScript(double size) {
    return GoogleFonts.dancingScript(
      fontSize: size,
      fontWeight: FontWeight.w700,
    );
  }

  TextStyle playFair(double size) {
    return GoogleFonts.playfairDisplay(
      fontSize: size,
      fontWeight: FontWeight.w700,
    );
  }

  TextStyle openSans(double size, Color color) {
    return GoogleFonts.openSans(
      fontSize: size,
      color: color
    );
  }

  TextStyle openSansSemiBold(double size, Color color) {
    return GoogleFonts.openSans(
      fontSize: size,
      fontWeight: FontWeight.w600,
      color: color
    );
  }

  TextStyle openSansBold(double size, Color color) {
    return GoogleFonts.openSans(
        fontSize: size,
        fontWeight: FontWeight.w700,
        color: color
    );
  }
}