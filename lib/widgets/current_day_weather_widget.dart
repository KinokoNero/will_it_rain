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
      padding: const EdgeInsets.only(bottom: 16),
      color: Colors.blue,
      child: Center(
        child: Column(
          children: [
            Text(
              '${closestWeather.currentTemperature?.round()}°C',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 48.0,
              ),
            ),
            // TODO: add weather icon here
            Text(
              '${closestWeather.description}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24.0,
              ),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: weatherForecast.currentDayHourlyWeather.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.blue[300],
                    child: Column(
                      children: [
                        Text(
                          '${weatherForecast.currentDayHourlyWeather[index].dateTime.hour}:${weatherForecast.currentDayHourlyWeather[index].dateTime.minute.toString().padLeft(2, '0')}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                          ),
                        ),
                        // TODO: add weather icon here
                        Text(
                          '${weatherForecast.currentDayHourlyWeather[index].currentTemperature?.round()}°C',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}