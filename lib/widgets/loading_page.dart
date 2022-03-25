import 'package:flutter/cupertino.dart';
import 'package:weather_app/data/contstants.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Image.asset(
        loadingAsset,
        height: size.height / 10,
      ),
    );
  }
}
