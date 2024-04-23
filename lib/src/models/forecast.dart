import 'wind.dart';
import 'rating.dart';

class Forecast {
  final int timestamp;
  Rating rating;
  Wind wind;

  Forecast({
    required this.timestamp,
    required this.rating,
    required this.wind,
  });

  factory Forecast.groupModels(Rating rating, Wind wind) {
    int timestamp = rating.timestamp;

    return Forecast(timestamp: timestamp, rating: rating, wind: wind);
  }

  List<Forecast> groupEntitiesByTimestamp(
      List<Rating> ratingEntities, List<Wind> windEntities) {
    List<Forecast> forecastList = [];

    for (Rating ratingEntity in ratingEntities) {
      int timestamp = ratingEntity.timestamp;

      // Find the corresponding wind entity for the current timestamp
      Wind matchingWind =
          windEntities.firstWhere((wind) => wind.timestamp == timestamp);

      // Create a new Forecast entity and add it to the list
      forecastList.add(Forecast(
          timestamp: timestamp, rating: ratingEntity, wind: matchingWind));
    }

    return forecastList;
  }

  @override
  String toString() {
    return 'Forecast($rating : $wind)';
  }
}
