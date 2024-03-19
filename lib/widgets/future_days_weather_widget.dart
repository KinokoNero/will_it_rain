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
          //margin: const EdgeInsets.symmetric(vertical: 5.0),
          color: Colors.blue,
          child: Center(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    '${weatherForecast.futureDaysDailyWeather[index].dateTime.day.toString().padRight(1, '0')}/${weatherForecast.futureDaysDailyWeather[index].dateTime.month.toString().padRight(1, '0')} ${weatherForecast.futureDaysDailyWeather[index].weekDayName}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                // TODO: add weather icon here
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
                  child: Text(
                    '${weatherForecast.futureDaysDailyWeather[index].minTemperature?.round()}° / ${weatherForecast.futureDaysDailyWeather[index].maxTemperature?.round()}°',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}