import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:will_it_rain/services/location_service.dart';
import 'package:will_it_rain/providers/weather_provider.dart';
import 'package:will_it_rain/widgets/current_day_weather_widget.dart';
import 'package:will_it_rain/widgets/future_days_weather_widget.dart';

final LocationService locationService = LocationService();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: const App(),
    ),
  );
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  late Future<void> _weatherInitialization;

  @override
  void initState() {
    super.initState();
    _weatherInitialization = _initializeWeatherData();
  }

  Future<void> _initializeWeatherData() async {
    final weatherProvider = Provider.of<WeatherProvider>(context, listen: false);
    await weatherProvider.fetchWeatherForecast(await LocationService.getLocationData());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Will it rain?'),
        ),
        body: Consumer<WeatherProvider>(
          builder: (context, weatherProvider, child) {
            return FutureBuilder<void>(
              future: _weatherInitialization,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }
                else {
                  return const Column(
                    children: <Widget>[
                      Expanded(
                        child: CurrentDayWeatherWidget()
                      ),
                      Expanded(
                        child: FutureDaysWeatherWidget()
                      ),
                      Text(
                        'Data provided by AccuWeather',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8.0,
                        ),
                      ),
                    ],
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}

/*void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //runApp(const App());
  runApp(
    ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: const App(),
    ),
  );
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  late Future<void> _weatherInitialization;

  @override
  void initState() {
    super.initState();
    _weatherInitialization = _initializeWeatherData();
  }

  Future<void> _initializeWeatherData() async {
    final weatherProvider = Provider.of<WeatherProvider>(context, listen: false);
    await weatherProvider.fetchWeatherForecast(await LocationService.getLocationData());
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Weather App'),
          ),
          body: Consumer<WeatherProvider>(
            builder: (context, cart, child) {
              return FutureBuilder(
                future: _weatherInitialization,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }
                  else {
                    return const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CurrentDayWeatherWidget(),
                        FutureDaysWeatherWidget(),
                      ],
                    );
                  }
                },
              );
            },
          ),
        )
      ),
    );
  }
}*/