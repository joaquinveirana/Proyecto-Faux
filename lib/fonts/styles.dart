import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FontStyles {
  TextStyle playFair(double size) {
    return GoogleFonts.playfairDisplay(
      fontSize: size,
      fontWeight: FontWeight.w700,
    );
  }

  TextStyle openSans(double size) {
    return GoogleFonts.openSans(
      fontSize: size,
    );
  }

  TextStyle openSansBold(double size) {
    return GoogleFonts.openSans(
      fontSize: size,
      fontWeight: FontWeight.w700,
    );
  }
}