import 'package:flutter/material.dart';
import 'package:make_your_plan/widgets/home.dart';
import 'package:flutter/services.dart';

var colorSceern = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(149, 35, 1, 255),
);

var darkColor = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(91, 29, 29, 29));

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) {});

  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: darkColor,
        cardTheme: const CardTheme().copyWith(
          color: darkColor.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: darkColor.primaryContainer,
            foregroundColor: darkColor.onPrimaryContainer,
          ),
        ),
      ),
      theme: ThemeData().copyWith(
        colorScheme: colorSceern,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: colorSceern.onPrimaryContainer,
          foregroundColor: colorSceern.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: colorSceern.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: colorSceern.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                color: colorSceern.onSecondaryContainer,
                fontSize: 10,
              ),
            ),
      ),
      home: const MyHomePage(),
    ),
  );
}
