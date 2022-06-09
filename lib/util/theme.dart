import 'package:flutter/material.dart';

ThemeData light = ThemeData(
    useMaterial3: true,
    textTheme: const TextTheme(
      titleMedium: TextStyle(fontWeight: FontWeight.w400),
    ),
    brightness: Brightness.light,
    primaryColor: const Color(0xFFF0F2F5),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF00B591),
      onSecondary: Color(0xFF00A6B5),
      secondary: Color(0xFF09B091),
    ),
    appBarTheme: const AppBarTheme(
        surfaceTintColor: Color(0xFFF0F2F5),
        color: Color(0xFFF0F2F5),
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFF000000)),
        titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w400,
            color: Color(0xFF000000))),
    scaffoldBackgroundColor: const Color(0xFFF0F2F5),
    cardTheme: const CardTheme(
      color: Color(0xFFFCFEFF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: Color(0xFFF0F2F5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(28)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
        focusColor:  const Color(0xFF00B591),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFF00B591),
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey[300]!,
            ),
            borderRadius: BorderRadius.circular(8.0)),
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey[300]!,
            ),
            borderRadius: BorderRadius.circular(8.0))),
    bottomAppBarColor: const Color(0xFFE0E0E0),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFFF0F2F5),
    ),
    navigationBarTheme: NavigationBarThemeData(
        backgroundColor: const Color(0xFFF0F2F5),
        indicatorColor: const Color(0xFF00B591),
        iconTheme: MaterialStateProperty.all(const IconThemeData(
          color: Color(0xFF050505),
        )),
        labelTextStyle: MaterialStateProperty.all(const TextStyle(
            color: Color(0xFF050505), fontWeight: FontWeight.w500))),
    bottomSheetTheme:
    const BottomSheetThemeData(modalBackgroundColor: Color(0xFFF0F2F5)));

ThemeData dark = ThemeData(
    useMaterial3: true,
    textTheme: const TextTheme(
      titleMedium: TextStyle(fontWeight: FontWeight.w400),
    ),
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF1F242A),
    scaffoldBackgroundColor: const Color(0xFF1F242A),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF73E3A6),
      onSecondary: Color(0xFF22B0D4),
      secondary: Color(0xFF60B286),
    ),
    appBarTheme: const AppBarTheme(
        surfaceTintColor:  Color(0xFF1F242A),
        backgroundColor: Color(0xFF1F242A),
    ),
    cardTheme: const CardTheme(
      surfaceTintColor: Color(0xFF1F242A),
      color: Color(0xFF1F242A),      
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: Color(0xFF1F242A),      
    ),
    inputDecorationTheme: InputDecorationTheme(
        focusColor: const Color(0xFF73E3A6),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFF73E3A6),
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey[850]!,
            ),
            borderRadius: BorderRadius.circular(8.0)),
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey[850]!,
            ),
            borderRadius: BorderRadius.circular(8.0))),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF1F242A),
    ),
    bottomAppBarColor: const Color(0xFF1F242A),
    navigationBarTheme: NavigationBarThemeData(
        backgroundColor: const Color(0xFF1F242A),//0xFF202122
        indicatorColor: const Color(0xFF438863),
        iconTheme: MaterialStateProperty.all(const IconThemeData(
          color: Color(0xFFE0E3E1),
        )),
        labelTextStyle: MaterialStateProperty.all(const TextStyle(
            color: Color(0xFFE0E3E1), fontWeight: FontWeight.w500))),
    bottomSheetTheme:
    const BottomSheetThemeData(modalBackgroundColor: Color(0xFF1F242A)));
