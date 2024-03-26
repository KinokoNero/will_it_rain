// Represents either:
// data from 12 hour weather at the specific time
// or
// data from 5 day forecast at the specific day

import 'package:flutter/cupertino.dart';

class Weather {
  late final DateTime _dateTime;
  late final double? _currentTemperature;
  late final double? _minTemperature;
  late final double? _maxTemperature;
  late final String? _description;
  late final int _iconId;
  late final int? _rainProbability; // %

  static const Map<int, String> iconMap = {
    1: 'clear',
    2: 'few-clouds',
    3: 'few-clouds',
    4: 'few-clouds',
    5: 'few-clouds',
    6: 'clouds',
    7: 'many-clouds',
    8: 'many-clouds',
    11: 'many-clouds',
    12: 'showers-scattered',
    13: 'showers-scattered',
    14: 'showers-scattered-day',
    15: 'storm',
    16: 'storm',
    17: 'storm-day',
    18: 'showers',
    19: 'snow-scattered',
    20: 'snow-scattered',
    21: 'snow-scattered-day',
    22: 'snow',
    23: 'snow',
    24: 'ice',
    25: 'snow-rain',
    26: 'freezing-rain',
    29: 'snow-rain',
    33: 'clear-night',
    34: 'few-clouds-night',
    35: 'few-clouds-night',
    36: 'few-clouds-night',
    37: 'clouds-night',
    38: 'clouds-night',
    39: 'showers-scattered-night',
    40: 'showers-scattered-night',
    41: 'storm-night',
    42: 'storm-night',
    43: 'snow-scattered-night',
    44: 'snow-scattered-night'
  };

  Weather(Map<String, dynamic> weatherData, bool is12HourForecast) {
    if (is12HourForecast) {
      _dateTime = DateTime.parse(weatherData['DateTime']);
      _currentTemperature = weatherData['Temperature']['Value'];
      _description = weatherData['IconPhrase'];
      _iconId = weatherData['WeatherIcon'];
      _rainProbability = weatherData['RainProbability'];
    }
    else {
      _dateTime = DateTime.parse(weatherData['Date']);
      _minTemperature = weatherData['Temperature']['Minimum']['Value'];
      _maxTemperature = weatherData['Temperature']['Maximum']['Value'];
      _description = weatherData['Day']['IconPhrase'];
      _iconId = weatherData['Day']['Icon'];
      _rainProbability = weatherData['Day']['RainProbability'];
    }
  }

  String get weekDayName {
    DateTime now = DateTime.now();
    if (_dateTime.day == now.day && _dateTime.month == now.month && _dateTime.year == now.year) {
      return "Today";
    }

    int dayOfWeek = _dateTime.weekday;
    switch (dayOfWeek) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return 'Unknown';
    }
  }

  AssetImage get weatherIcon {
    return AssetImage('assets/weathericons/${iconMap[iconId]}.png');
  }

  int? get rainProbability => _rainProbability;

  int get iconId => _iconId;

  String? get description => _description;

  double? get maxTemperature => _maxTemperature;

  double? get minTemperature => _minTemperature;

  double? get currentTemperature => _currentTemperature;

  DateTime get dateTime => _dateTime;
}