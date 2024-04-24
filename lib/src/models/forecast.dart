import 'wind.dart';
import 'rating.dart';
import 'weather.dart';
import 'tide.dart';
import 'wave.dart';

class Forecast {
  final int timestamp;
  Rating rating;
  Tide tide;
  Wave wave;
  Weather weather;
  Wind wind;

  Forecast({
    required this.timestamp,
    required this.rating,
    required this.tide,
    required this.wave,
    required this.weather,
    required this.wind,
  });

  factory Forecast.groupModels(
      Rating rating, Tide tide, Wave wave, Weather weather, Wind wind) {
    int timestamp = rating.timestamp;

    return Forecast(
        timestamp: timestamp,
        rating: rating,
        tide: tide,
        wave: wave,
        weather: weather,
        wind: wind);
  }

  @override
  String toString() {
    return 'Forecast($rating : $wind)';
  }
}
