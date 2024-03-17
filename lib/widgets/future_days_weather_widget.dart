import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/weather_provider.dart';

class FutureDaysWeatherWidget extends StatelessWidget {
  const FutureDaysWeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final weatherForecast = weatherProvider.weatherForecast;

    return ListView.builder(
      itemCount: weatherForecast.futureDaysDailyWeather.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(vertical: 5.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: ListTile(
            title: Text(weatherForecast.futureDaysDailyWeather[index].minTemperature.toString()),
          ),
        );
      },
    );
  }
}