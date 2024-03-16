import 'package:flutter/material.dart';

import '../models/forecast_model.dart';

class WeatherWidget extends StatelessWidget {
  final List<ForecastDay> forecast;

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
  }
}