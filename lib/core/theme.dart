import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bluishClr = Color(0xFF4e5ae8);
const Color orangeClr = Color(0xCFFF8746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const primaryClr = bluishClr;
const Color darkGreyClr = Color.fromARGB(255, 0, 0, 0);
const Color darkHeaderClr = Color(0xFF424242);

class Themes {
  static final light = ThemeData(
      indicatorColor: Colors.black,
      backgroundColor: white,
      primaryColor: primaryClr,
      brightness: Brightness.light);
  static final dark = ThemeData(
      backgroundColor: darkGreyClr,
      primaryColor: darkGreyClr,
      brightness: Brightness.dark);
}

TextStyle get headingstyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  ));
}

TextStyle get subheadingstyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color:  Colors.black,
  ));
}

TextStyle get titlestyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color:  Colors.black,
  ));
}

TextStyle get subtitlestyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color:  Colors.black,
  ));
}

TextStyle get bodystyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color:  Colors.black,
  ));
}

TextStyle get body2style {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color:  Colors.black,
  ));
}
