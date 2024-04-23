import 'package:surf/src/entities/rating_entity.dart';

class Rating {
  int timestamp;
  int value;

  Rating({
    required this.timestamp,
    required this.value,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      timestamp: json['timestamp'],
      value: json['value'],
    );
  }

  RatingEntity toRatingEntity() {
    return RatingEntity(
      timestamp: timestamp,
      utcOffset: 2,
      ratingValue: RatingValue(
        key: 'POOR', // Provide appropriate value for key
        value: value,
      ),
    );
  }

  @override
  String toString() {
    return 'Rating ($timestamp : $value)';
  }
}
