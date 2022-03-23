import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:weather_app/screens/choose_location.dart';

void main() async {
  await initializeDateFormatting();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.lightBlue,
        primaryColorLight: Colors.white,
        primaryColorDark: Colors.grey.shade900,
        // iconTheme: const IconThemeData(color: Colors.white),
        fontFamily: 'Poppins',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      home: const ChooseLocation(title: 'Weather App'),
    );
  }
}
