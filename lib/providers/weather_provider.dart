import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:weather_app/models/waether.dart';
import 'package:weather_app/services/weather_api.dart';
import 'package:weather_app/providers/location_provider.dart';

class WeatherProvider with ChangeNotifier {
  Weather? _weather;
  late bool _isDay;
  late bool _error;
  late String _errorMessage;
  final LocationProvider? _locationProvider;
  late String _appBarTitle;

  WeatherProvider(this._locationProvider) {
    _error = false;
    _errorMessage = '';
    _isDay = true;
    _appBarTitle = "Weather app";
    if (_locationProvider != null) {
      if (_locationProvider!.location != null) {
        getWeather();
      } else if (_locationProvider!.error) {
        _givesError(_locationProvider!.errorMessage);
      }
    }
  }

  Weather? get weather => _weather;
  bool get isDay => _isDay;
  bool get error => _error;
  String get errorMessage => _errorMessage;
  String get appBarTitle => _appBarTitle;

  Future getWeather() async {
    try {
      _initalizeError();
      log("tryna get weather !!");
      Weather? weather =
          await WeatherApi.getWeather(_locationProvider!.location!);
      log("got weather successfully !!");
      _weather = weather;
      if (_weather!.timezone!.isAfter(_weather!.sunrise!) &&
          _weather!.timezone!.isBefore(_weather!.sunset!)) {
        _isDay = true;
      } else {
        _isDay = false;
      }
      _appBarTitle = '${weather!.cityName}, ${weather.country}';
    } catch (e) {
      _givesError(e);
    }
    notifyListeners();
  }

  //some private methods
  _givesError(e) {
    _error = true;
    _errorMessage = e.toString();
    _appBarTitle = "Weather app";
    notifyListeners();
  }

  _initalizeError() {
    _error = false;
    _errorMessage = '';
    notifyListeners();
  }
}
