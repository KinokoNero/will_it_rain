import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:will_it_rain/services/location_service.dart';
import 'package:will_it_rain/services/weather_service.dart';
import 'package:will_it_rain/widgets/weather_widget.dart';

import 'models/forecast_model.dart';

final LocationService locationService = LocationService();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Will it rain?',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Will it rain?"),
        ),
        body: Center(
          child: FutureBuilder<LocationData>(
            future: LocationService.getLocationData(),
            builder: (context, locationSnapshot) {
              if (locationSnapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (locationSnapshot.hasError) {
                return Text('Error: ${locationSnapshot.error}');
              } else {
                return FutureBuilder<List<ForecastDay>>(
                  future: WeatherService.get5DayForecast(locationSnapshot.data!),
                  builder: (context, forecastSnapshot) {
                    if (forecastSnapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (forecastSnapshot.hasError) {
                      return Text('Error: ${forecastSnapshot.error}');
                    } else {
                      return WeatherWidget(
                        forecast: forecastSnapshot.data!,
                      );
                    }
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
