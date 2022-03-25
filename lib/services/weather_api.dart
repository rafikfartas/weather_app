import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/data/contstants.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/waether.dart';

class WeatherApi {
  ////http://api.openweathermap.org/data/2.5/weather?lat=[Latitude]&lon=[Longitude]&appid=[apiKey]
  static Future<Weather>? getWeather(
    LatLng position,
  ) async {
    try {
      final lat = position.latitude;
      final lon = position.longitude;
      // final queryParameters = {
      //   'lat': position.latitude.toDouble(),
      //   'lon': position.longitude.toDouble(),
      //   'appid': weatherApiKey,
      // };
      // log(queryParameters.toString());
      // final uri = Uri.https(
      //   'api.openweathermap.org',
      //   '/data/2.5/weather',
      //   queryParameters,
      // );
      final uri = Uri.parse(
          "http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&appid=$weatherApiKey");

      final response = await http.get(uri);
      final json = jsonDecode(response.body);

      return Weather().fromJSON(json);
    } catch (e) {
      // log(e.toString());
      // return Weather();
      return Future.error("Couldn't get the response from the api");
    }
  }
}
