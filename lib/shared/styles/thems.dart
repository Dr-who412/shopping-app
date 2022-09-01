import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

final theme= ThemeData(
primaryColor: Colors.deepOrange,
scaffoldBackgroundColor: Colors.white,
appBarTheme: const AppBarTheme(
systemOverlayStyle: SystemUiOverlayStyle(
statusBarBrightness: Brightness.dark,
statusBarColor: Colors.grey,
),
iconTheme: IconThemeData(
color: Colors.black,
),
backgroundColor: Colors.white,
elevation: 0.0,
),
bottomNavigationBarTheme: const BottomNavigationBarThemeData(
backgroundColor: Colors.white,
  showUnselectedLabels: true,
  showSelectedLabels: false,
type: BottomNavigationBarType.fixed,
elevation: 0.0,
selectedItemColor: Colors.deepOrange,
unselectedItemColor: Colors.deepOrangeAccent,
selectedIconTheme: IconThemeData(size: 50),
),
primarySwatch: Colors.deepOrange,
textTheme:  const TextTheme(
bodyText1: TextStyle(
color: Colors.black,
fontSize: 14,
fontWeight: FontWeight.bold,
),
),
);
final darktheme= ThemeData(
primaryColor: Colors.deepOrange,
scaffoldBackgroundColor: HexColor('333739'),
backgroundColor: HexColor('333739'),
appBarTheme: AppBarTheme(
backwardsCompatibility: false,
backgroundColor: HexColor('333739'),
systemOverlayStyle: const SystemUiOverlayStyle(
statusBarBrightness: Brightness.light,
statusBarColor: Colors.black,
),
titleTextStyle: TextStyle(
color: Colors.white,
fontWeight: FontWeight.bold,
fontSize: 20.0,
),
iconTheme: const IconThemeData(
color: Colors.white,
)),
bottomNavigationBarTheme: BottomNavigationBarThemeData(
backgroundColor: HexColor('333739'),
selectedItemColor: Colors.deepOrange,
unselectedItemColor: Colors.grey,
elevation: 20.0,
type: BottomNavigationBarType.fixed,
),
textTheme:  const TextTheme(
bodyText1: TextStyle(
color: Colors.white,
fontSize: 14,
fontWeight: FontWeight.bold,
),
),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.white70,
        elevation: 0.5,

  ),
    iconTheme: const IconThemeData(
      color: Colors.deepOrange,
    ),
  primaryIconTheme: IconThemeData(
    color: Colors.deepOrange,
  ),

);