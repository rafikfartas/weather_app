import 'package:weather_app/services/string_extension.dart';

class Weather {
  int? lon;
  int? lat;
  String? cityName;
  String? country;
  String? description;
  int? temperature;
  int? tempMin;
  int? tempMax;
  int? pressure;
  int? humidity;
  int? visibility;
  double? windSpeed;
  int? windDegree;
  int? rain1h;
  int? rain3h;
  int? snow1h;
  int? snow3h;
  int? clouds;
  DateTime? timezone;
  DateTime? sunrise;
  DateTime? sunset;
  Weather({
    this.lon,
    this.lat,
    this.cityName,
    this.country,
    this.description,
    this.temperature,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
    this.visibility,
    this.windSpeed,
    this.windDegree,
    this.rain1h,
    this.rain3h,
    this.snow1h,
    this.snow3h,
    this.clouds,
    this.timezone,
    this.sunrise,
    this.sunset,
  });

  Weather fromJSON(Map<String, dynamic> map) {
    return Weather(
      lon: map['coord']['lon'].roundToDouble().toInt(),
      lat: map['coord']['lat'].roundToDouble().toInt(),
      cityName: map['name'],
      country: map['sys']['country'],
      description: map['weather'][0]['description'].toString().toTitleCase(),
      temperature: map['main']['temp']?.roundToDouble().toInt(),
      tempMin: map['main']['temp_min']?.roundToDouble().toInt(),
      tempMax: map['main']['temp_max']?.roundToDouble().toInt(),
      pressure: map['main']['pressure']?.roundToDouble().toInt(),
      humidity: map['main']['humidity']?.roundToDouble().toInt(),
      visibility:
          (map['visibility']?.toDouble() / 1000).roundToDouble().toInt(),
      windSpeed: map['wind']['speed']?.roundToDouble() * 3.6,
      windDegree: map['wind']['deg']?.roundToDouble().toInt(),
      rain1h: map['rain'] == null
          ? null
          : map['rain']['1h']?.roundToDouble().toInt(),
      rain3h: map['rain'] == null
          ? null
          : map['rain']['3h']?.roundToDouble().toInt(),
      snow1h: map['snow'] == null
          ? null
          : map['snow']['1h']?.roundToDouble().toInt(),
      snow3h: map['snow'] == null
          ? null
          : map['snow']['3h']?.roundToDouble().toInt(),
      clouds: map['clouds']['all']?.roundToDouble().toInt(),
      timezone: DateTime.now()
          .add(DateTime.now().timeZoneOffset)
          .add(Duration(seconds: map['timezone']!)),
      sunrise:
          DateTime.fromMillisecondsSinceEpoch(map['sys']['sunrise'] * 1000),
      sunset: DateTime.fromMillisecondsSinceEpoch(map['sys']['sunset'] * 1000),
    );
  }

  // round() {
  //   // int s = sunrise * 100;
  //   DateTime time = DateTime.fromMillisecondsSinceEpoch(sunrise! * 1000);
  //   print(time);
  // }

  static equals(Weather w1, Weather w2) {
    if (w1.cityName == w2.cityName &&
        w1.clouds == w2.clouds &&
        w1.country == w2.country &&
        w1.description == w2.description &&
        w1.humidity == w2.humidity &&
        w1.lat == w2.lat &&
        w1.lon == w2.lon &&
        w1.pressure == w2.pressure &&
        w1.rain1h == w2.rain1h &&
        w1.rain3h == w2.rain3h &&
        w1.snow1h == w2.snow1h &&
        w1.snow3h == w2.snow3h &&
        w1.sunrise == w2.sunrise &&
        w1.sunset == w2.sunset &&
        w1.tempMax == w2.tempMax &&
        w1.tempMin == w2.tempMin &&
        w1.temperature == w2.temperature &&
        w1.timezone == w2.timezone &&
        w1.visibility == w2.visibility &&
        w1.windDegree == w2.windDegree &&
        w1.windSpeed == w2.windSpeed) {
      return true;
    } else {
      return false;
    }
  }
}
