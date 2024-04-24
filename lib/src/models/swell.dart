import 'package:surf/src/entities/swell_entity.dart';

class Swell {
  double direction;
  double directionMin;
  double height;
  double impact;
  int optimalScore;
  int period;
  double power;

  Swell({
    required this.direction,
    required this.directionMin,
    required this.height,
    required this.impact,
    required this.optimalScore,
    required this.period,
    required this.power,
  });

  factory Swell.fromJson(Map<String, dynamic> json) {
    return Swell(
      direction: json['direction'],
      directionMin: json['directionMin'],
      height: json['height'],
      impact: json['impact'],
      optimalScore: json['optimalScore'],
      period: json['period'],
      power: json['power'],
    );
  }

  SwellEntity toSwellEntity() {
    return SwellEntity(
      direction: direction,
      directionMin: directionMin,
      height: height,
      impact: impact,
      optimalScore: optimalScore,
      period: period,
      power: power,
    );
  }

  @override
  String toString() {
    return 'Swell($height)';
  }
}
