import 'package:flutter/material.dart';
import 'package:surf/src/components/weather_icon.dart';
import 'package:surf/src/models/weather.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;

  const WeatherCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 8,
      margin: EdgeInsets.zero,
      shadowColor: const Color.fromRGBO(97, 216, 240, 0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: WeatherIcon(condition: weather.condition),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${weather.temperature.round().toString()}°C',
                          style: Theme.of(context).textTheme.labelMedium),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
