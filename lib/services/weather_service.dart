import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

import 'package:will_it_rain/api_key.dart';
import 'package:will_it_rain/models/forecast_model.dart';

class WeatherService {
  static Future<String> _getLocationKey(LocationData locationData) async {
    final queryParams = {
      'apikey': apiKey,
      'q': '${locationData.latitude.toString()},${locationData.longitude.toString()}',
      'details': 'true'
    };
    final Uri uri = Uri.http('dataservice.accuweather.com',
        '/locations/v1/cities/geoposition/search', queryParams);

    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);

      if (data.containsKey('Details')) {
        Map<String, dynamic> details = data['Details'];

        if (details.containsKey('CanonicalLocationKey')) {
          String canonicalLocationKey = details['CanonicalLocationKey'];
          return canonicalLocationKey;
        }
        else {
          throw Exception('Could not get the canonical location key data!');
        }
      }
      else {
        throw Exception('Could not get the location key details data!');
      }
    }
    else {
      throw Exception('Failed to fetch location key data. Status code: ${response.statusCode}');
    }
  }

  static Future<List<ForecastDay>> get5DayForecast(LocationData locationData) async {
    String locationKey = await _getLocationKey(locationData);

    final queryParams = {
      'apikey': apiKey,
      'details': 'true',
      'metric': 'true'
    };
    final Uri uri = Uri.http('dataservice.accuweather.com', '/forecasts/v1/daily/5day/$locationKey', queryParams);

    http.Response response = await http.get(uri);

    List<ForecastDay> forecast = [];

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);

      if (data.containsKey('DailyForecasts')) {
        List<dynamic> days = data['DailyForecasts'];
        for (var day in days) {
          forecast.add(ForecastDay(day));
        }

        return forecast;
      }
      else {
        throw Exception('Failed to get data for daily forecasts!');
      }
    }
    else {
      throw Exception('Failed to fetch forecast data. Status code: ${response.statusCode}');
    }
  }
}