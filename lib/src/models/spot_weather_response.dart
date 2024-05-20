import 'package:surf/src/models/sunlight.dart';
import 'package:surf/src/models/weather.dart';

class SpotWeatherResponse {
  final List<Weather> weather;
  final List<Sunlight> sunlight;

  SpotWeatherResponse({required this.weather, required this.sunlight});
}
