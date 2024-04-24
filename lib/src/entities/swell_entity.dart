import 'package:surf/src/models/swell.dart';

class SwellEntity {
  double direction;
  double directionMin;
  double height;
  double impact;
  int optimalScore;
  int period;
  double power;

  SwellEntity({
    required this.direction,
    required this.directionMin,
    required this.height,
    required this.impact,
    required this.optimalScore,
    required this.period,
    required this.power,
  });

  factory SwellEntity.fromJson(Map<String, dynamic> json) {
    return SwellEntity(
      direction: json['direction'].toDouble(),
      directionMin: json['directionMin'].toDouble(),
      height: json['height'].toDouble(),
      impact: json['impact'].toDouble(),
      optimalScore: json['optimalScore'],
      period: json['period'],
      power: json['power'].toDouble(),
    );
  }

  Swell toSwell() {
    return Swell(
        direction: direction,
        directionMin: directionMin,
        height: height,
        impact: impact,
        optimalScore: optimalScore,
        period: period,
        power: power);
  }
}
