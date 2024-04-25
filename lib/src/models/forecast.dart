import 'wind.dart';
import 'rating.dart';
import 'weather.dart';
import 'tide.dart';
import 'surf.dart';
import 'swell.dart';

class Forecast {
  final int timestamp;
  Rating rating;
  Surf surf;
  Swell swell;
  Tide tide;
  Weather weather;
  Wind wind;

  Forecast({
    required this.timestamp,
    required this.rating,
    required this.surf,
    required this.swell,
    required this.tide,
    required this.weather,
    required this.wind,
  });

  factory Forecast.groupModels(Rating rating, Surf surf, Swell swell, Tide tide,
      Weather weather, Wind wind) {
    int timestamp = rating.timestamp;

    return Forecast(
        timestamp: timestamp,
        rating: rating,
        surf: surf,
        swell: swell,
        tide: tide,
        weather: weather,
        wind: wind);
  }

  @override
  String toString() {
    return 'Forecast($rating : $wind)';
  }
}
