import 'package:flutter/material.dart';

import 'package:expense_tracker/expenses.dart';

var kColorScheme = ColorScheme.fromSeed(seedColor: 
  const Color.fromARGB(255, 96, 59, 181)
);
void main() {
  runApp(
     MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData().copyWith(
          colorScheme: kColorScheme,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kColorScheme.onPrimaryContainer,
            foregroundColor: kColorScheme.primaryContainer,

          ),
          cardTheme: const CardTheme().copyWith(
            color: kColorScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,

            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kColorScheme.primaryContainer,
            ),

          ),
        ),
      home: const Expenses(),
    ),
  );
}