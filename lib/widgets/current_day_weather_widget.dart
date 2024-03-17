import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/weather_model.dart';
import '../providers/weather_provider.dart';

class CurrentDayWeatherWidget extends StatelessWidget {
  const CurrentDayWeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final weatherForecast = weatherProvider.weatherForecast;

    DateTime currentTime = DateTime.now();
    Weather closestWeather = weatherForecast.currentDayHourlyWeather.first;
    Duration minDifference = (closestWeather.dateTime).difference(currentTime).abs();
    for (var weather in weatherForecast.currentDayHourlyWeather) {
      Duration difference = (weather.dateTime).difference(currentTime).abs();
      if (difference < minDifference) {
        minDifference = difference;
        closestWeather = weather;
      }
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.5,
      color: Colors.blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${closestWeather.currentTemperature} °C',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24.0,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '${closestWeather.description}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: weatherForecast.currentDayHourlyWeather.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  padding: const EdgeInsets.all(10.0),
                  color: Colors.white,
                  child: Text(
                    '${weatherForecast.currentDayHourlyWeather[index].dateTime.toString()}\n${weatherForecast.currentDayHourlyWeather[index].currentTemperature.toString()}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}