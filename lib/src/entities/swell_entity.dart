import 'package:surf/src/models/swell.dart';

class SwellElementEntity {
  double direction;
  double directionMin;
  double height;
  double impact;
  int period;
  double power;

  SwellElementEntity({
    required this.direction,
    required this.directionMin,
    required this.height,
    required this.impact,
    required this.period,
    required this.power,
  });

  factory SwellElementEntity.fromJson(Map<String, dynamic> json) {
    return SwellElementEntity(
      direction: json['direction']?.toDouble(),
      directionMin: json['directionMin']?.toDouble(),
      height: json['height']?.toDouble(),
      impact: json['impact']?.toDouble(),
      period: json['period'],
      power: json['power']?.toDouble(),
    );
  }

  SwellElement toSwellElement() {
    return SwellElement(
      direction: direction,
      directionMin: directionMin,
      height: height,
      impact: impact,
      period: period,
      power: power,
    );
  }
}

class SwellEntity {
  List<SwellElementEntity> swells;
  double power;
  int timestamp;
  int utcOffset;

  SwellEntity({
    required this.swells,
    required this.power,
    required this.timestamp,
    required this.utcOffset,
  });

  factory SwellEntity.fromJson(Map<String, dynamic> json) {
    List<dynamic> swellsJson = json['swells'];
    List<SwellElementEntity> swells = swellsJson
        .map((swellJson) => SwellElementEntity.fromJson(swellJson))
        .toList();

    return SwellEntity(
      swells: swells,
      power: json['power']?.toDouble() ?? 0.0,
      timestamp: json['timestamp'],
      utcOffset: json['utcOffset'],
    );
  }

  Swell toSwell() {
    return Swell(
      swells: swells.map((element) => element.toSwellElement()).toList(),
      power: power,
      timestamp: timestamp,
      utcOffset: utcOffset,
    );
  }
}
