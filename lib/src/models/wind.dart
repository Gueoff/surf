import 'package:surf/src/entities/wind_entity.dart';

class Wind {
  double direction;
  String directionType;
  double gust;
  double speed;
  int timestamp;

  Wind({
    required this.direction,
    required this.directionType,
    required this.gust,
    required this.speed,
    required this.timestamp,
  });

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      direction: json['direction'],
      directionType: json['directionType'],
      gust: json['gust'],
      speed: json['speed'],
      timestamp: json['timestamp'],
    );
  }

  WindEntity toWindEntity() {
    return WindEntity(
      direction: direction,
      directionType: directionType,
      gust: gust,
      optimalScore: 0,
      speed: speed,
      timestamp: timestamp,
      utcOffset: 2,
    );
  }

  @override
  String toString() {
    return 'Wind($timestamp : $speed)';
  }
}
