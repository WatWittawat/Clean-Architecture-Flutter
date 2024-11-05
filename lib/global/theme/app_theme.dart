import 'package:clean_arch/global/generated/fonts.gen.dart';
import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: FontFamily.ibmPlexSansThai,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: Color(0xFF8B8B8B),
      ),
      titleTextStyle: TextStyle(
        color: Color(0xFF8B8B8B),
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
