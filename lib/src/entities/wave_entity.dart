import 'package:surf/src/entities/surf_entity.dart';
import 'package:surf/src/entities/swell_entity.dart';
import 'package:surf/src/models/wave.dart';

class WaveEntity {
  double power;
  double? probability;
  SurfEntity surf;
  List<SwellEntity> swells;
  int timestamp;
  int utcOffset;

  WaveEntity({
    required this.power,
    required this.probability,
    required this.surf,
    required this.swells,
    required this.timestamp,
    required this.utcOffset,
  });

  factory WaveEntity.fromJson(Map<String, dynamic> json) {
    SurfEntity surf = SurfEntity.fromJson(json['surf'] as Map<String, dynamic>);
    List<SwellEntity> swells = (json['swells'] as List)
        .map((swellJson) =>
            SwellEntity.fromJson(swellJson as Map<String, dynamic>))
        .toList();

    return WaveEntity(
      power: json['power'].toDouble(),
      probability: json['probability']?.toDouble(),
      surf: surf,
      swells: swells,
      timestamp: json['timestamp'],
      utcOffset: json['utcOffset'],
    );
  }

  Wave toWave() {
    return Wave(
      power: power,
      probability: probability,
      surf: surf.toSurf(),
      swells: swells.map((element) => element.toSwell()).toList(),
      timestamp: timestamp,
    );
  }
}
