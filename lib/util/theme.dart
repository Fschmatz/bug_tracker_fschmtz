import 'package:flutter/material.dart';

ThemeData light = ThemeData(
    useMaterial3: true,
    textTheme: const TextTheme(
      titleMedium: TextStyle(fontWeight: FontWeight.w400),
    ),
    brightness: Brightness.light,
    primaryColor: const Color(0xFFF0F2F5),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF006d3f),
      onPrimary: Color(0xFFFFFFFF),
      onSecondary: Color(0xFF00A6B5),
      secondary: Color(0xFF09B091),
    ),
    appBarTheme: const AppBarTheme(
        surfaceTintColor: Color(0xFFF0F2F5),
        color: Color(0xFFF0F2F5),
    ),
    scaffoldBackgroundColor: const Color(0xFFF0F2F5),
    cardTheme: const CardTheme(
      color: Color(0xFFFCFEFF),      
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: Color(0xFFF0F2F5),     
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
              color: Color(0xFF707971),
            ),
            borderRadius: BorderRadius.circular(8.0)),
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF707971),
            ),
            borderRadius: BorderRadius.circular(8.0))),
    bottomAppBarColor: const Color(0xFFE0E0E0),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFFF0F2F5),
    ),
    navigationBarTheme: NavigationBarThemeData(
        backgroundColor: const Color(0xFFF0F2F5),
        indicatorColor: const Color(0xFF098358),
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
    primaryColor: const Color(0xFF1F1F1F),
    scaffoldBackgroundColor: const Color(0xFF1F1F1F),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFA8C7FA),
      onPrimary: Color(0xFFC2E7FF),
      onSecondary: Color(0xFF2284D4),
      secondary: Color(0xFF6089B2),
    ),
    appBarTheme: const AppBarTheme(
        surfaceTintColor:  Color(0xFF1F1F1F),
        backgroundColor: Color(0xFF1F1F1F),
    ),
    cardTheme: const CardTheme(
      surfaceTintColor: Color(0xFF1F1F1F),
      color: Color(0xFF1F1F1F),      
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: Color(0xFF1F1F1F),      
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF1D6AA9),
    ),
    inputDecorationTheme: InputDecorationTheme(
        focusColor: const Color(0xFFA8C7FA),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFFA8C7FA),
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF8A9093),
            ),
            borderRadius: BorderRadius.circular(8.0)),
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF8A9093),
            ),
            borderRadius: BorderRadius.circular(8.0))),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF292C30),
    ),
    bottomAppBarColor: const Color(0xFF292C30),
    navigationBarTheme: NavigationBarThemeData(
        backgroundColor: const Color(0xFF292C30),//0xFF202122
        indicatorColor: const Color(0xFF004A77),
        iconTheme: MaterialStateProperty.all(const IconThemeData(
          color: Color(0xFFE3E3E3),
        )),
        labelTextStyle: MaterialStateProperty.all(const TextStyle(
            color: Color(0xFFE3E3E3), fontWeight: FontWeight.w500))),
    bottomSheetTheme:
    const BottomSheetThemeData(modalBackgroundColor: Color(0xFF1F1F1F)));
