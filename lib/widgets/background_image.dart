import 'package:flutter/material.dart';
import 'package:weather_app/data/contstants.dart';

Image backGroundImage(BuildContext context, bool isDay) {
  Size size = MediaQuery.of(context).size;
  return Image.asset(
    isDay ? morningAsset : nightAsset,
    fit: BoxFit.cover,
    height: size.height,
    width: size.width,
  );
}
