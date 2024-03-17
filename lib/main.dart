import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:will_it_rain/services/location_service.dart';
import 'package:will_it_rain/providers/weather_provider.dart';
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
    return ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: const MaterialApp(
        home: WeatherWidget(),
      ),
    );
  }
}
