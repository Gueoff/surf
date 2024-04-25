import 'package:surf/src/entities/weather_entity.dart';

class Weather {
  String condition;
  int pressure;
  double temperature;
  int timestamp;

  Weather({
    required this.condition,
    required this.pressure,
    required this.temperature,
    required this.timestamp,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      condition: json['condition'],
      pressure: json['pressure'],
      temperature: json['temperature'],
      timestamp: json['timestamp'],
    );
  }

  WeatherEntity toWeatherEntity() {
    return WeatherEntity(
      condition: condition,
      pressure: pressure,
      temperature: temperature,
      timestamp: timestamp,
      utcOffset: 2,
    );
  }

  @override
  String toString() {
    return 'Weather($timestamp : $condition)';
  }
}
