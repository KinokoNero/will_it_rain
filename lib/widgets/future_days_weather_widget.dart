import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/weather_provider.dart';

class FutureDaysWeatherWidget extends StatelessWidget {
  const FutureDaysWeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    final weatherProvider = Provider.of<WeatherProvider>(context);
    final weatherForecast = weatherProvider.weatherForecast;

    return Flexible(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: weatherForecast.futureDaysDailyWeather.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue,
              border: Border(
                top: BorderSide(
                  color: Colors.grey,
                  width: deviceSize.width * 0.003,
                ),
              )
            ),
            child: Row(
              children: [
                Text(
                  '${weatherForecast.futureDaysDailyWeather[index].dateTime.day.toString().padLeft(2, '0')}/${weatherForecast.futureDaysDailyWeather[index].dateTime.month.toString().padLeft(2, '0')} ${weatherForecast.futureDaysDailyWeather[index].weekDayName}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: deviceSize.width * 0.06,
                  ),
                ),
                const Spacer(),
                Expanded(
                  child: Image(
                    height: deviceSize.width * 0.2,
                    image: weatherForecast.futureDaysDailyWeather[index].weatherIcon,
                  ),
                ),
                const Spacer(),
                Text(
                  '${weatherForecast.futureDaysDailyWeather[index].minTemperature?.round()}° / ${weatherForecast.futureDaysDailyWeather[index].maxTemperature?.round()}°',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: deviceSize.width * 0.06,
                  ),
                ),
              ],
            ),
          );
        }
      )
    );
  }
}