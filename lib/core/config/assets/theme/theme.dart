import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes {
  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.grey[200],
      primaryColor: Colors.black,
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(backgroundColor: Colors.grey[200]),
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      listTileTheme: ListTileThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          tileColor: Colors.white,
          contentPadding: const EdgeInsets.all(8)),
      textTheme: GoogleFonts.openSansTextTheme());

  static ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.black12,
      primaryColor: Colors.white,
      brightness: Brightness.dark,
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      listTileTheme: ListTileThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          tileColor: Colors.grey[600],
          contentPadding: const EdgeInsets.all(8)),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black12,
      ),
      textTheme: GoogleFonts.openSansTextTheme());
}
