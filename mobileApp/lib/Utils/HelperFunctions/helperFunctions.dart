import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HelperFunctions {
  ThemeData buildTheme(brightness) {
    var baseTheme = ThemeData(brightness: brightness);

    return baseTheme.copyWith(
      textTheme: GoogleFonts.poppinsTextTheme(baseTheme.textTheme),
    );
  }

  String convertDate(String? releaseDate) {
    final parsedDate = DateTime.parse(releaseDate ?? "1999-12-01");
    final formattedDate = DateFormat('MMMM dd, yyyy').format(parsedDate);
    return formattedDate;
  }
}
