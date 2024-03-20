import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
      decoration: BoxDecoration(
          color: Colors.blue,
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: MediaQuery.of(context).size.height * 0.002
            ),
          )
      ),
      child: Column(
        children: [
          Flexible(child: Text(
            '${closestWeather.currentTemperature?.round()}°C',
            style: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.of(context).size.width * 0.13,
            ),
          ),),
          Flexible(child: Image(
            height: MediaQuery.of(context).size.height * 0.1,
            image: closestWeather.weatherIcon,
          ),),
          Flexible(child: Text(
            '${closestWeather.description}',
            style: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.of(context).size.width * 0.07,
            ),
          ),),
          Flexible(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: weatherForecast.currentDayHourlyWeather.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                      color: Colors.blue[300],
                      border: Border.all(
                        color: Colors.grey,
                        width: MediaQuery.of(context).size.width * 0.002
                      )
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          '${weatherForecast.currentDayHourlyWeather[index].dateTime.hour}:00',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width * 0.06,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Image(
                          height: MediaQuery.of(context).size.height * 0.08,
                          image: weatherForecast.currentDayHourlyWeather[index].weatherIcon,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          '${weatherForecast.currentDayHourlyWeather[index].currentTemperature?.round()}°C',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width * 0.06,
                          ),
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
    );
  }
}