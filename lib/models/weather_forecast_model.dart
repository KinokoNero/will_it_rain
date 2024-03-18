import 'package:will_it_rain/models/weather_model.dart';

class WeatherForecast {
  late List<Weather> _currentDayHourlyWeather;
  late List<Weather> _futureDaysDailyWeather;

  WeatherForecast() {
    _currentDayHourlyWeather = [];
    _futureDaysDailyWeather = [];
  }

  List<Weather> get futureDaysDailyWeather => _futureDaysDailyWeather;

  set futureDaysDailyWeather(List<Weather> value) {
    _futureDaysDailyWeather = value;
  }

  List<Weather> get currentDayHourlyWeather => _currentDayHourlyWeather;

  set currentDayHourlyWeather(List<Weather> value) {
    _currentDayHourlyWeather = value;
  }
}