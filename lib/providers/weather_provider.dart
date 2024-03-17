import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:will_it_rain/api_key.dart';
import 'package:will_it_rain/models/forecast_model.dart';

class WeatherProvider extends ChangeNotifier {
  final List<ForecastDay> _forecast = [];

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
      final data = json.decode(response.body);
      final List<dynamic> forecastDaysData = data['DailyForecasts'];

      for (var dayData in forecastDaysData) {
        ForecastDay forecastDay = ForecastDay(dayData);
        _forecast.add(forecastDay);
      }

      notifyListeners();
    }
    else {
      throw Exception('Failed to fetch forecast data. Status code: ${response.statusCode}');
    }
  }

  List<ForecastDay> get forecast => _forecast;
}