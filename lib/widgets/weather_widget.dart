import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:will_it_rain/services/location_service.dart';

import '../providers/weather_provider.dart';

class CurrentDayWeatherWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final forecast = weatherProvider.forecast;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<WeatherProvider>(
            builder: (context, provider, child) {
              //final forecast = provider.forecast;
              if (forecast.isNotEmpty) {
                return Column(
                  children: [
                    Text('Min: ${forecast.first.minTemperature}°C'),
                    Text('Max: ${forecast.first.maxTemperature}°C'),
                  ],
                );
              }
              else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}

class ForecastWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final forecast = weatherProvider.forecast;

    return Expanded(
      child: ListView.builder(
        itemCount: forecast.length,
        itemBuilder: (context, index) {
          final dayForecast = forecast[index];

          return ListTile(
            title: Text('Day ${index + 1}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Min Temperature: ${dayForecast.minTemperature}°C'),
                Text('Max Temperature: ${dayForecast.maxTemperature}°C'),
              ],
            ),
          );
        },
      ),
    );
  }
}

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({super.key});

  @override
  WeatherWidgetState createState() => WeatherWidgetState();
}

class WeatherWidgetState extends State<WeatherWidget> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeWeatherData();
  }

  Future<void> _initializeWeatherData() async {
    final weatherProvider = Provider.of<WeatherProvider>(context, listen: false);
    await weatherProvider.fetch5DayForecast(await LocationService.getLocationData());
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Center(
        child: _isLoading ? const CircularProgressIndicator() : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          if (weatherProvider.forecast.isNotEmpty)
            CurrentDayWeatherWidget(),//Text('${weatherProvider.forecast.first.minTemperature}°C'),
            ForecastWidget(),
          if (weatherProvider.forecast.isEmpty)
            Text('No forecast'),
          ],
        ),
      ),
    );
  }


  /*final List<ForecastDay> forecast;

  const WeatherWidget({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.blue, // Customize the background color
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.wb_sunny,
            size: 50.0,
            color: Colors.yellow,
          ),
          const SizedBox(height: 10.0),
          Text(
            forecast.first.dayIconPhrase, //TODO: temporary
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10.0),
          const Icon(
            Icons.nightlight_round,
            size: 50.0,
            color: Colors.grey,
          ),
          const SizedBox(height: 10.0),
          Text(
            forecast.first.nightIconPhrase, //TODO: temporary
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }*/
}