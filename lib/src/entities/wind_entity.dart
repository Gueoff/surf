import 'package:surf/src/models/wind.dart';

class WindEntity {
  double direction;
  String directionType;
  double gust;
  int optimalScore;
  double speed;
  int timestamp;
  int utcOffset;

  WindEntity({
    required this.direction,
    required this.directionType,
    required this.gust,
    required this.optimalScore,
    required this.speed,
    required this.timestamp,
    required this.utcOffset,
  });

  factory WindEntity.fromJson(Map<String, dynamic> json) {
    return WindEntity(
      direction: json['direction'],
      directionType: json['directionType'],
      gust: json['gust'],
      optimalScore: json['optimalScore'],
      speed: json['speed'],
      timestamp: json['timestamp'],
      utcOffset: json['utcOffset'],
    );
  }

  Wind toWind() {
    return Wind(
      direction: direction,
      directionType: directionType,
      gust: gust,
      speed: speed,
      timestamp: timestamp,
    );
  }
}
