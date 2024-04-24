import 'package:surf/src/models/weather.dart';

class WeatherEntity {
  String condition;
  int pressure;
  double temperature;
  int timestamp;
  int utcOffset;

  WeatherEntity({
    required this.condition,
    required this.pressure,
    required this.temperature,
    required this.timestamp,
    required this.utcOffset,
  });

  factory WeatherEntity.fromJson(Map<String, dynamic> json) {
    return WeatherEntity(
      condition: json['condition'],
      pressure: json['pressure'],
      temperature: json['temperature'],
      timestamp: json['timestamp'],
      utcOffset: json['utcOffset'],
    );
  }

  Weather toWeather() {
    return Weather(
      condition: condition,
      pressure: pressure,
      temperature: temperature,
      timestamp: timestamp,
    );
  }
}
