import 'package:flutter/material.dart';

import 'package:weather_app/data/contstants.dart';
import 'package:weather_app/screens/location_map.dart';
import 'package:weather_app/screens/weather_page.dart';
import 'package:weather_app/widgets/custom_card.dart';

class ChooseLocation extends StatefulWidget {
  final String title;
  const ChooseLocation({Key? key, required this.title}) : super(key: key);

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  late String asset = morningAsset;

  @override
  void initState() {
    _getTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        _backgroundAsset(size),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    cloudSunAsset,
                    width: size.width - 100,
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      Text(
                        widget.title,
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Showing weather anywhere, \nmore than basic info",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Image.asset(
                    cloudsAsset,
                    width: size.width - 60,
                  ),
                  const SizedBox(height: 50),
                  CustomContainer(
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) =>
                                  const LocationMap(title: "Weather App"),
                            ),
                          ),
                          child: Text(
                            "Choose location",
                            style:
                                Theme.of(context).textTheme.subtitle1!.copyWith(
                                      color: Colors.grey.shade900,
                                    ),
                          ),
                        ),
                        Divider(
                          color: Colors.grey.shade900.withOpacity(0.1),
                          thickness: 1,
                          indent: 10,
                          endIndent: 10,
                          height: 25,
                        ),
                        InkWell(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) =>
                                  const WeatherPage(title: "Weather App"),
                            ),
                          ),
                          child: Text(
                            "Current location",
                            style:
                                Theme.of(context).textTheme.subtitle1!.copyWith(
                                      color: Colors.grey.shade900,
                                    ),
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

  void _getTime() {
    int nowHour = DateTime.now().hour;
    if (nowHour >= 7 && nowHour <= 19) {
      asset = morningAsset;
    } else {
      asset = nightAsset;
    }
  }

  Image _backgroundAsset(Size size) => Image.asset(
        morningAsset,
        fit: BoxFit.cover,
        height: size.height,
        width: size.width,
      );
}
