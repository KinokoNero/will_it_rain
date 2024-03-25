import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:will_it_rain/api_key.dart';
import 'package:will_it_rain/data/scheduled_notifications.dart';
import 'package:will_it_rain/models/weather_forecast_model.dart';

import '../models/weather_model.dart';

class WeatherProvider extends ChangeNotifier {
  late final WeatherForecast _weatherForecast = WeatherForecast();

  Future<String> _getLocationKey(LocationData locationData) async {
    final queryParams = {
      'apikey': apiKey,
      'q': '${locationData.latitude.toString()},${locationData.longitude.toString()}',
      'details': 'true'
    };
    final Uri uri = Uri.http('dataservice.accuweather.com',
        '/locations/v1/cities/geoposition/search', queryParams);

    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['Details']['CanonicalLocationKey'];
    }
    else {
      throw Exception('Failed to fetch location key data. Status code: ${response.statusCode}');
    }
  }

  Future<void> fetch12HourForecast(LocationData locationData) async {
    String locationKey = await _getLocationKey(locationData);

    final queryParams = {
      'apikey': apiKey,
      'details': 'true',
      'metric': 'true'
    };
    final Uri uri = Uri.http('dataservice.accuweather.com', '/forecasts/v1/hourly/12hour/$locationKey', queryParams);

    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> forecastHoursData = jsonDecode(response.body);

      for (var hourData in forecastHoursData) {
        Weather weather = Weather(hourData, true);
        _weatherForecast.currentDayHourlyWeather.add(weather);

        if (weather.rainAmount! > 0) {
          ScheduledNotifications.itWillRain(true);
        }
      }

      notifyListeners();
    }
    else {
      throw Exception('Failed to fetch forecast data. Status code: ${response.statusCode}');
    }
  }

  Future<void> fetch5DayForecast(LocationData locationData) async {
    String locationKey = await _getLocationKey(locationData);

    final queryParams = {
      'apikey': apiKey,
      'details': 'true',
      'metric': 'true'
    };
    final Uri uri = Uri.http('dataservice.accuweather.com', '/forecasts/v1/daily/5day/$locationKey', queryParams);

    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> forecastDaysData = data['DailyForecasts'];

      for (var dayData in forecastDaysData) {
        Weather weather = Weather(dayData, false);
        _weatherForecast.futureDaysDailyWeather.add(weather);
      }

      notifyListeners();
    }
    else {
      throw Exception('Failed to fetch forecast data. Status code: ${response.statusCode}');
    }
  }

  Future<void> fetchWeatherForecast(LocationData locationData) async {
    await fetch12HourForecast(locationData);
    await fetch5DayForecast(locationData);
    notifyListeners();
  }

  WeatherForecast get weatherForecast => _weatherForecast;
}