import 'package:clima/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/utilities/debugging.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  final WeatherModel weather = WeatherModel();

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {

    var weatherData = await weather.getLocationWeather();

    if(weatherData == null) {
      debugLocationStatusMessage = "WeatherData is null!";
    }

    if(debugLocationStatusMessage != 'Ok!') {
      debugLocationStatusMessage = "Isn't ok!";
      return;
    }

    if(!mounted) {
      debugLocationStatusMessage = "Not mounted";
      return;
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(locationWeather: weatherData);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SpinKitRing(
            color: Colors.white,
            size: 100
          ),
          const SizedBox(
            height: 30.0,
          ),
          Text(
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25.0
              ),
              debugLocationStatusMessage
          )
        ],
      )
    );
  }
}
