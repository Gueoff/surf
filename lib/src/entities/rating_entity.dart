import 'package:surf/src/models/rating.dart';

class RatingEntity {
  int timestamp;
  int utcOffset;
  RatingValue ratingValue;

  RatingEntity({
    required this.timestamp,
    required this.utcOffset,
    required this.ratingValue,
  });

  factory RatingEntity.fromJson(Map<String, dynamic> json) {
    return RatingEntity(
      timestamp: json['timestamp'],
      utcOffset: json['utcOffset'],
      ratingValue: RatingValue.fromJson(json['rating']),
    );
  }

  Rating toRating() {
    return Rating(
      timestamp: timestamp,
      value: ratingValue.value,
    );
  }
}

class RatingValue {
  String key;
  int value;

  RatingValue({
    required this.key,
    required this.value,
  });

  factory RatingValue.fromJson(Map<String, dynamic> json) {
    return RatingValue(
      key: json['key'],
      value: json['value'],
    );
  }

  RatingEntity toRatingEntity(int timestamp, int utcOffset) {
    return RatingEntity(
      timestamp: timestamp,
      utcOffset: utcOffset,
      ratingValue: this,
    );
  }
}
