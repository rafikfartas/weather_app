import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:weather_app/managers/route_manager.dart';
import 'package:weather_app/screens/home.dart';

void main() async {
  await initializeDateFormatting();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return generateProvider(
      MaterialApp(
        title: 'Weather App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primaryColorLight: Colors.white,
          primaryColorDark: Colors.grey.shade900,
          fontFamily: 'Poppins',
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.blue,
            accentColor: Colors.amber,
          ).copyWith(secondary: Colors.white),
          textTheme: Theme.of(context)
              .textTheme
              .apply(bodyColor: Colors.white, displayColor: Colors.white),
        ),
        // onGenerateRoute: RouteManager.generateRoute,
        // initialRoute: homePage,
        home: const Home(),
      ),
    );
  }
}
