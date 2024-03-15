import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;

import 'package:will_it_rain/api_key.dart';
import 'package:will_it_rain/models/forecast_model.dart';

class WeatherService {
  getLocationKey(double latitude, double longitude) async {
    final queryParams = {
      'apikey': apiKey,
      'q': '${latitude.toString()},${longitude.toString()}',
      'details': true
    };
    final Uri uri = Uri.http('dataservice.accuweather.com', '/locations/v1/cities/geoposition/search', queryParams);

    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);

      if (data.containsKey('Details')) {
        Map<String, dynamic> details = data['Details'];

        if (details.containsKey('CanonicalLocationKey')) {
          String canonicalLocationKey = details['CanonicalLocationKey'];
          return canonicalLocationKey;
        }
      }
    }
    else {
      print('Failed to fetch data. Status code: ${response.statusCode}'); //TODO: handle error codes
    }
  }

  get5DayForecast(String locationKey) async {
    final queryParams = {
      'apikey': apiKey,
      'details': true,
      'metric': true
    };
    final Uri uri = Uri.http('dataservice.accuweather.com', '/forecasts/v1/daily/5day/$locationKey', queryParams);

    http.Response response = await http.get(uri);

    var forecast = [];

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);

      if (data.containsKey('DailyForecasts')) {
        List<dynamic> days = data['DailyForecasts'];
        for (var day in days) {
          forecast.add(ForecastDay(day));
        }

        return forecast;
      }
    }
    else {
      print('Failed to fetch data. Status code: ${response.statusCode}'); //TODO: handle error codes
    }
  }
}