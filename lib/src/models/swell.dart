import 'package:surf/src/entities/swell_entity.dart';

class SwellElement {
  double direction;
  double directionMin;
  double height;
  double impact;
  int period;
  double power;

  SwellElement({
    required this.direction,
    required this.directionMin,
    required this.height,
    required this.impact,
    required this.period,
    required this.power,
  });

  factory SwellElement.fromJson(Map<String, dynamic> json) {
    return SwellElement(
      direction: json['direction']?.toDouble(),
      directionMin: json['directionMin']?.toDouble(),
      height: json['height']?.toDouble(),
      impact: json['impact']?.toDouble(),
      period: json['period'],
      power: json['power']?.toDouble(),
    );
  }

  SwellElementEntity toSwellElement() {
    return SwellElementEntity(
      direction: direction,
      directionMin: directionMin,
      height: height,
      impact: impact,
      period: period,
      power: power,
    );
  }
}

class Swell {
  List<SwellElement> swells;
  double power;
  int timestamp;
  int utcOffset;

  Swell({
    required this.swells,
    required this.power,
    required this.timestamp,
    required this.utcOffset,
  });

  factory Swell.fromJson(Map<String, dynamic> json) {
    return Swell(
      swells: json['swells'],
      power: json['power'],
      timestamp: json['timestamp'],
      utcOffset: json['utcOffset'],
    );
  }

  SwellEntity toSwellEntity() {
    return SwellEntity(
      swells: swells.map((element) => element.toSwellElement()).toList(),
      power: power,
      timestamp: timestamp,
      utcOffset: 2,
    );
  }

  @override
  String toString() {
    return 'Swell($power)';
  }
}
