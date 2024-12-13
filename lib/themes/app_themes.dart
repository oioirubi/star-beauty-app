import 'package:flutter/material.dart';

// Definição de Cores Personalizadas
const Color roxo = Color(0xFF472C9B); // Cor #472C9B
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
    ).copyWith(
      secondary: amarelo,
      surface: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.black45,
    ),
    scaffoldBackgroundColor: branquinho,
    appBarTheme: const AppBarTheme(
      backgroundColor: roxo,
      foregroundColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        minimumSize: const Size(150, 50),
        backgroundColor: roxo,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
      ),
    ),
    // Estilo de InputDecoration (para TextField/TextFormField)
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[100], // Fundo do campo
      labelStyle: const TextStyle(
        color: roxo, // Cor do label
        fontSize: 16,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Color(0xFFD3D3D3), // Borda padrão
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: roxo.withOpacity(0.7), // Borda em destaque ao focar
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.red, // Borda de erro
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.redAccent, // Borda de erro ao focar
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  );
}
