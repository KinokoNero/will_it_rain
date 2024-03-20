import 'package:flutter/cupertino.dart';
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
          decoration: BoxDecoration(
            color: Colors.blue,
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: MediaQuery.of(context).size.height * 0.002,
              ),
            )
          ),
          child: Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    '${weatherForecast.futureDaysDailyWeather[index].dateTime.day.toString().padLeft(2, '0')}/${weatherForecast.futureDaysDailyWeather[index].dateTime.month.toString().padLeft(2, '0')} ${weatherForecast.futureDaysDailyWeather[index].weekDayName}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width * 0.06,
                    ),
                  ),
                ),
                //const Spacer(),
                Flexible(
                  child: Image(
                    height: MediaQuery.of(context).size.height * 0.08,
                    image: weatherForecast.futureDaysDailyWeather[index].weatherIcon,
                  ),
                ),
                //const Spacer(),
                Flexible(
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