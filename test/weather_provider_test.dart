import 'package:flutter_test/flutter_test.dart';
import 'package:will_it_rain/providers/weather_provider.dart';
import 'package:location/location.dart';

void main() {
  group('WeatherProvider Tests', () {
    test('fetch12HourForecast should populate currentDayHourlyWeather list', () async {
      final weatherProvider = WeatherProvider();
      final locationData = LocationData.fromMap({'latitude': 37.7749, 'longitude': -122.4194});

      await weatherProvider.fetch12HourForecast(locationData);

      expect(weatherProvider.weatherForecast.currentDayHourlyWeather.isNotEmpty, true);
    });

    test('fetch5DayForecast should populate futureDaysDailyWeather list', () async {
      final weatherProvider = WeatherProvider();
      final locationData = LocationData.fromMap({'latitude': 37.7749, 'longitude': -122.4194});

      await weatherProvider.fetch5DayForecast(locationData);

      expect(weatherProvider.weatherForecast.futureDaysDailyWeather.isNotEmpty, true);
    });
  });
}