import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/location_provider.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/screens/home.dart';

class RouteManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return generateProvider(const Home());
      default:
        throw const FormatException("Couldn't find the route");
    }
  }
}

generateProvider(Widget child) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<LocationProvider>(
          create: (ctx) => LocationProvider()),
      ChangeNotifierProxyProvider<LocationProvider, WeatherProvider>(
        create: (ctx) => WeatherProvider(null),
        update: (ctx, LocationProvider location, WeatherProvider? weather) =>
            WeatherProvider(location),
      )
    ],
    child: child,
  );
}

const String homePage = '/';
const String weatherPage = '/weather';
