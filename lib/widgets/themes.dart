import 'package:flutter/material.dart';

BoxDecoration cardImageBoxDecoration() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(8)),
    border: Border.all(
      width: 2.5,
      color: Colors.lightBlueAccent
    )
  );
}

BoxDecoration cardButtonBoxDecoration() {
  return BoxDecoration(
    color: Colors.blueGrey[700],
    borderRadius: BorderRadius.all(Radius.circular(8)),
    border: Border.all(
      width: 1.5,
      color: Colors.black,
    )
  );
}

ThemeData defaultAppTheme() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey[900]!),
    appBarTheme: AppBarTheme(
      color: Colors.blueGrey[900],
      iconTheme: IconThemeData(
        color: Colors.white
      ),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 25,
      ),
    ),
    scaffoldBackgroundColor: Colors.blueGrey[700],
    cardTheme: CardTheme(
      color: Colors.blueGrey[900],
    )
  );
}

ThemeData blueAppTheme() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue[900]!),
    appBarTheme: AppBarTheme(
      color: Colors.blue[900],
      iconTheme: IconThemeData(),
      titleTextStyle: TextStyle(),
    ),
    scaffoldBackgroundColor: Colors.blueGrey[700],
    cardTheme: CardTheme()
  );
}

ThemeData redAppTheme() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.red[900]!),
    appBarTheme: AppBarTheme(
      color: Colors.red[900],
      iconTheme: IconThemeData(),
      titleTextStyle: TextStyle(),
    ),
    scaffoldBackgroundColor: Colors.blueGrey[700],
    cardTheme: CardTheme()
  );
}