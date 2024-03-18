// Represents either:
// data from 12 hour weather at the specific time
// or
// data from 5 day forecast at the specific day

class Weather {
  late final DateTime _dateTime;
  late final double? _currentTemperature;
  late final double? _minTemperature;
  late final double? _maxTemperature;
  late final String? _description;
  late final int _iconId;
  late final double? _rainAmount; // In millimeters

  Weather(Map<String, dynamic> weatherData, bool is12HourForecast) {
    if (is12HourForecast) {
      _dateTime = DateTime.parse(weatherData['DateTime']);
      _currentTemperature = weatherData['Temperature']['Value'];
      _description = weatherData['IconPhrase'];
      _iconId = weatherData['WeatherIcon'];
      _rainAmount = weatherData['Rain']['Value'];
    }
    else {
      _dateTime = DateTime.parse(weatherData['Date']);
      _minTemperature = weatherData['Temperature']['Minimum']['Value'];
      _maxTemperature = weatherData['Temperature']['Maximum']['Value'];
      _description = weatherData['Day']['IconPhrase'];
      _iconId = weatherData['Day']['Icon'];
    }
  }

  double? get rainAmount => _rainAmount;

  int get iconId => _iconId;

  String? get description => _description;

  double? get maxTemperature => _maxTemperature;

  double? get minTemperature => _minTemperature;

  double? get currentTemperature => _currentTemperature;

  DateTime get dateTime => _dateTime;
}