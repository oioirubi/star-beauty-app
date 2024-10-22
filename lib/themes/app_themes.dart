import 'package:flutter/material.dart';

// Definição de Cores Personalizadas
const Color roxo = Color(0xFF472C9B); // Cor #472C9B
const Color lilas = Color(0xFFB5A0FF); // Cor #B5A0FF
const Color branquinho = Color(0xFFF5F5F5); // Cor #F5F5F5
const Color amarelinho = Color(0xFFFFC857); // Cor #FFC857
const Color amarelo = Color(0xFFFFAA00); // Cor #FFAA00

// MaterialColor baseado na cor primária
Map<int, Color> roxoSwatch = {
  50: const Color.fromRGBO(71, 44, 155, .1),
  100: const Color.fromRGBO(71, 44, 155, .2),
  200: const Color.fromRGBO(71, 44, 155, .3),
  300: const Color.fromRGBO(71, 44, 155, .4),
  400: const Color.fromRGBO(71, 44, 155, .5),
  500: const Color.fromRGBO(71, 44, 155, .6),
  600: const Color.fromRGBO(71, 44, 155, .7),
  700: const Color.fromRGBO(71, 44, 155, .8),
  800: const Color.fromRGBO(71, 44, 155, .9),
  900: const Color.fromRGBO(71, 44, 155, 1),
};

MaterialColor customRoxoSwatch = MaterialColor(0xFF472C9B, roxoSwatch);

// Função para Tema Claro
ThemeData lightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    primarySwatch: customRoxoSwatch,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: customRoxoSwatch,
      brightness:
          Brightness.light, // Adicionado para sincronizar com o tema claro
    ).copyWith(
      secondary: amarelo,
      surface: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.blueGrey[900],
    ),
    scaffoldBackgroundColor: branquinho,
    appBarTheme: const AppBarTheme(
      backgroundColor: roxo,
      foregroundColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed))
            return roxo.withOpacity(0.8);
          if (states.contains(MaterialState.hovered))
            return roxo.withOpacity(0.9);
          return roxo; // Cor padrão
        }),
      ),
    ),
    iconTheme: IconThemeData(
      color: Colors.blueGrey[900],
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: roxo,
      foregroundColor: amarelo,
    ),
    textTheme: TextTheme(
      headlineLarge: const TextStyle(
          fontSize: 32.0, fontWeight: FontWeight.bold, color: roxo),
      headlineSmall: const TextStyle(
          fontSize: 24.0, fontWeight: FontWeight.bold, color: amarelo),
      bodyLarge: TextStyle(fontSize: 16.0, color: Colors.blueGrey[900]),
      bodySmall: TextStyle(fontSize: 14.0, color: Colors.blueGrey[700]),
      labelLarge: const TextStyle(
          fontSize: 14.0, fontWeight: FontWeight.w600, color: amarelo),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.blueGrey[50],
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blueGrey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: roxo),
        borderRadius: BorderRadius.circular(10.0),
      ),
      hintStyle: TextStyle(color: Colors.blueGrey[500]),
    ),
  );
}

ThemeData darkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    primarySwatch: customRoxoSwatch,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: customRoxoSwatch,
      brightness:
          Brightness.dark, // Adicionado para sincronizar com o tema escuro
    ).copyWith(
      secondary: amarelo,
      surface: Colors.blueGrey[900], // Blue Grey ao invés de preto
      onPrimary: branquinho,
      onSecondary: amarelo,
      onSurface: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.blueGrey[800],
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blueGrey[900], // Blue Grey escuro
      foregroundColor: amarelo,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed))
            return roxo.withOpacity(0.8);
          if (states.contains(MaterialState.hovered))
            return roxo.withOpacity(0.9);
          return roxo;
        }),
      ),
    ),
    iconTheme: const IconThemeData(
      color: amarelinho,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: roxo,
      foregroundColor: amarelo,
    ),
    textTheme: TextTheme(
      headlineLarge: const TextStyle(
          fontSize: 32.0, fontWeight: FontWeight.bold, color: amarelinho),
      headlineSmall: const TextStyle(
          fontSize: 24.0, fontWeight: FontWeight.bold, color: lilas),
      bodyLarge: const TextStyle(fontSize: 16.0, color: Colors.white),
      bodySmall: const TextStyle(fontSize: 14.0, color: Colors.white70),
      labelLarge: const TextStyle(
          fontSize: 14.0, fontWeight: FontWeight.w600, color: roxo),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.blueGrey[800],
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: lilas),
        borderRadius: BorderRadius.circular(10.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: amarelinho),
        borderRadius: BorderRadius.circular(10.0),
      ),
      hintStyle: const TextStyle(color: Colors.white70),
    ),
  );
}
