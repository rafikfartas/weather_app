import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/data/contstants.dart';
import 'package:weather_app/widgets/background_image.dart';
import 'package:weather_app/models/waether.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/screens/choose_location.dart';
import 'package:weather_app/widgets/custom_card.dart';
import 'package:weather_app/widgets/dividers.dart';
import 'package:weather_app/widgets/loading_page.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
      builder: (ctx, consumer, child) {
        return Stack(
          children: [
            backGroundImage(context, consumer.isDay),
            Scaffold(
              backgroundColor: Colors.transparent,
              appBar: _buildAppBar(context, consumer),
              body: Builder(
                builder: (ctx) {
                  if (consumer.error) {
                    return _buildError(context, consumer.errorMessage);
                  } else if (consumer.weather == null) {
                    return const LoadingPage();
                  } else {
                    return _buildWeatherPage(context, consumer);
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }

  _buildAppBar(BuildContext context, WeatherProvider consumer) {
    return AppBar(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      title: Text(consumer.appBarTitle),
      leading: IconButton(
        onPressed: () async {
          await consumer.getWeather();
        },
        icon: const Icon(Icons.refresh),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ChooseLocation(),
              ),
            );
          },
          icon: const Icon(Icons.location_on_outlined),
        ),
      ],
    );
  }

  _buildError(BuildContext context, String error) {
    return Center(
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
    );
  }

  Widget _buildWeatherPage(BuildContext context, WeatherProvider consumer) {
    Size size = MediaQuery.of(context).size;
    Weather weather = consumer.weather!;
    bool isDay = consumer.isDay;
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  DateFormat.yMMMM().add_jm().format(weather.timezone!),
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.white),
                ),
              ],
            ),
            Image.asset(
              isDay ? cloudSunAsset : moonAsset,
              width: size.width / 4,
            ),
            Column(
              children: [
                Text(
                  "${weather.temperature ?? 'No'}°",
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(color: Colors.white),
                ),
                Text(
                  weather.description ?? 'No',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: Colors.white),
                ),
              ],
            ),
            Image.asset(
              cloudsAsset,
              width: size.width / 5,
            ),
            // const SizedBox(height: 30),
            DefaultTextStyle(
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: Colors.black),
              overflow: TextOverflow.ellipsis,
              child: CustomContainer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mininum: + ${weather.tempMin ?? 'No'}°',
                          ),
                          divider20,
                          Text(
                            'Sunrise: ${DateFormat.jm().format(weather.sunrise!)}',
                          ),
                          divider20,
                          Text(
                            'Humidity: ${weather.humidity ?? 'No'} %',
                          ),
                          divider20,
                          Text(
                            'Visibility: ${weather.visibility ?? 'No'} km',
                          ),
                          divider20,
                          Text(
                            'Rain: ${weather.rain1h ?? 'No'} ${weather.rain1h != null ? 'mm' : ''}',
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Maximum: ${weather.tempMax ?? 'No'}°',
                          ),
                          divider20,
                          Text(
                            'Sunset: ${DateFormat.jm().format(weather.sunset!)}',
                          ),
                          divider20,
                          Text(
                            'Pressure: ${weather.pressure ?? 'No'} hPa',
                          ),
                          divider20,
                          Text(
                            'Wind speed: ${weather.windSpeed ?? 'No'} km/h',
                          ),
                          divider20,
                          Text(
                            'Snow: ${weather.snow1h ?? 'No'} ${weather.snow1h != null ? 'mm' : ''}',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
