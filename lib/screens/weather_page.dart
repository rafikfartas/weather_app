import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/data/contstants.dart';
import 'package:weather_app/models/waether.dart';
import 'package:weather_app/services/location_api.dart';
import 'package:weather_app/services/weather_api.dart';
import 'package:weather_app/widgets/custom_card.dart';
import 'package:weather_app/widgets/loading_page.dart';

class WeatherPage extends StatefulWidget {
  final String title;
  final LatLng? choosedPosition;
  const WeatherPage({Key? key, required this.title, this.choosedPosition})
      : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late Weather _weather;
  late LatLng _position;
  bool isDay = true;
  // late Timer _timer;
  @override
  void initState() {
    // _timer = Timer.periodic(const Duration(minutes: 1), (Timer time) {
    //   setState(() {});
    // });
    super.initState();
  }

  @override
  void dispose() {
    // _timer.cancel();
    super.dispose();
  }

  @override
  void deactivate() {
    // _timer.cancel();
    super.deactivate();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.choosedPosition == null
        ? _buildCurrentLocationFuture(context)
        : _buildChoosedLocationFuture(context);
  }

  Widget _buildCurrentLocationFuture(BuildContext context) {
    return FutureBuilder<LatLng>(
      future: LocationApi().getCurrentLocation(),
      builder: (context, AsyncSnapshot<LatLng> position) {
        if (!position.hasData) {
          return const LoadingPage();
        } else if (position.hasError) {
          return _buildWeatherError(context);
        } else {
          log(position.toString());
          _position = position.data ?? position.requireData;
          return _buildWeatherFuture(context);
        }
      },
    );
  }

  Widget _buildChoosedLocationFuture(BuildContext context) {
    _position = widget.choosedPosition!;
    return _buildWeatherFuture(context);
  }

  Widget _buildWeatherFuture(BuildContext context) {
    return FutureBuilder<Weather>(
        future: WeatherApi.getWeather(_position),
        builder: (context, AsyncSnapshot<Weather> snapshot) {
          if (snapshot.hasError) {
            return _buildWeatherError(context);
          }
          if (!snapshot.hasData) {
            return const LoadingPage();
          } else {
            _weather = snapshot.data ?? snapshot.requireData;
            if (_weather.cityName == null) {
              return _buildWeatherError(context);
            } else {
              if (DateTime.now().isAfter(_weather.sunrise!) &&
                  DateTime.now().isBefore(_weather.sunset!)) {
                isDay = true;
              } else {
                isDay = false;
              }
              return _buildWeatherPage(context);
            }
          }
        });
  }

  Widget _buildWeatherPage(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        _imageAsset(context),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
              '${_weather.cityName}, ${_weather.country}',
              style: const TextStyle(color: Colors.white),
            ),
            centerTitle: true,
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat.yMMMM().add_jm().format(_weather.timezone!),
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.white),
                  ),
                  Image.asset(
                    isDay ? cloudSunAsset : moonAsset,
                    width: size.width / 3,
                  ),
                  Column(
                    children: [
                      Text(
                        "${_weather.temperature ?? 'No'}°",
                        style: Theme.of(context)
                            .textTheme
                            .headline2!
                            .copyWith(color: Colors.white),
                      ),
                      Text(
                        _weather.description ?? 'No',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                  Image.asset(
                    cloudsAsset,
                    width: size.width / 2,
                  ),
                  // const SizedBox(height: 30),
                  CustomContainer(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'mininum: + ${_weather.tempMin ?? 'No'}°',
                                style: Theme.of(context).textTheme.bodyText2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              divider20,
                              Text(
                                'Sunrise: ${DateFormat.jm().format(_weather.sunrise!)}',
                                style: Theme.of(context).textTheme.bodyText2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              divider20,
                              Text(
                                'humidity: ${_weather.humidity ?? 'No'} %',
                                style: Theme.of(context).textTheme.bodyText2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              divider20,
                              Text(
                                'visibility: ${_weather.visibility ?? 'No'} km',
                                style: Theme.of(context).textTheme.bodyText2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              divider20,
                              Text(
                                'rain: ${_weather.rain1h ?? 'No'} mm',
                                style: Theme.of(context).textTheme.bodyText2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'maximum: ${_weather.tempMax ?? 'No'}°',
                                style: Theme.of(context).textTheme.bodyText2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              divider20,
                              Text(
                                'sunset: ${DateFormat.jm().format(_weather.sunset!)}',
                                style: Theme.of(context).textTheme.bodyText2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              divider20,
                              Text(
                                'pressure: ${_weather.pressure ?? 'No'} hPa',
                                style: Theme.of(context).textTheme.bodyText2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              divider20,
                              Text(
                                'Wind speed: ${_weather.windSpeed ?? 'No'} km/h',
                                style: Theme.of(context).textTheme.bodyText2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              divider20,
                              Text(
                                'snow: ${_weather.snow1h ?? 'No'} mm',
                                style: Theme.of(context).textTheme.bodyText2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWeatherError(BuildContext context) {
    return Stack(
      children: [
        _imageAsset(context),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
              widget.title,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Error loading data",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: Colors.white),
                ),
                divider20,
                Text(
                  "1 -> Verify your internet connexion",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.white),
                ),
                Text(
                  "2 -> Enable location in your phone seetings",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Image _imageAsset(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Image.asset(
      isDay ? morningAsset : nightAsset,
      fit: BoxFit.cover,
      height: size.height,
      width: size.width,
    );
  }
}

Widget divider20 =
    const Divider(height: 20, thickness: 0, color: Colors.transparent);
Widget divider10 =
    const Divider(height: 10, thickness: 0, color: Colors.transparent);
