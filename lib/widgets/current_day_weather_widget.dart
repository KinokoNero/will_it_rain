import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/weather_model.dart';
import '../providers/weather_provider.dart';

class CurrentDayWeatherWidget extends StatelessWidget {
  const CurrentDayWeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

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
      height: deviceSize.height * 0.485,
      color: Colors.blue,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${closestWeather.currentTemperature?.round()}°C',
            style: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.of(context).size.width * 0.13,
            ),
          ),
          Image(
            height: MediaQuery.of(context).size.height * 0.15,
            image: closestWeather.weatherIcon,
          ),
          Text(
            '${closestWeather.description}',
            style: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.of(context).size.width * 0.07,
            ),
          ),
          Flexible(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: weatherForecast.currentDayHourlyWeather.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.blue[300],
                      border: Border.all(
                        color: Colors.grey,
                        width: deviceSize.width * 0.002
                      )
                  ),
                  child: Column(
                    children: [
                      Text(
                        '${weatherForecast.currentDayHourlyWeather[index].dateTime.hour}:00',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: deviceSize.height * 0.03,
                        ),
                      ),
                      Image(
                        height: MediaQuery.of(context).size.height * 0.08,
                        image: weatherForecast.currentDayHourlyWeather[index].weatherIcon,
                      ),
                      Text(
                        '${weatherForecast.currentDayHourlyWeather[index].currentTemperature?.round()}°C',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: deviceSize.height * 0.03,
                        ),
                      ),
                    ]
                  ),
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}