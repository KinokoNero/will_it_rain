import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:will_it_rain/services/location_service.dart';
import 'package:will_it_rain/providers/weather_provider.dart';
import 'package:will_it_rain/services/notification_service.dart';
import 'package:will_it_rain/widgets/current_day_weather_widget.dart';
import 'package:will_it_rain/widgets/future_days_weather_widget.dart';

final LocationService locationService = LocationService();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
  await NotificationService.scheduleNotifications();

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
    final deviceSize = MediaQuery.of(context).size;

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

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
                  return Column(
                    children: [
                      const CurrentDayWeatherWidget(),
                      const FutureDaysWeatherWidget(),
                      Column(
                        children: [
                          const Text(
                            'Data provided by AccuWeather',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                          ),
                          Image(
                            width: deviceSize.width * 0.4,
                            image: const AssetImage('assets/accuweather-logo.png'),
                          ),
                        ]
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