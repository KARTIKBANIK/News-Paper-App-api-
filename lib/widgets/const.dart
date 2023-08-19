import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

myStyle(double? size, Color? clr, [FontWeight? fw]) {
  return GoogleFonts.nunito(
    fontSize: size,
    color: clr,
    fontWeight: fw,
  );
}

String apiKey = "ad3e33e29eb7452e824fa3ac498c3054";
String baseUrl = "https://newsapi.org/";
