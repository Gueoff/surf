import 'package:surf/src/entities/wave_entity.dart';
import 'package:surf/src/models/surf.dart';
import 'package:surf/src/models/swell.dart';

class Wave {
  double power;
  double? probability;
  Surf surf;
  List<Swell> swells;
  int timestamp;

  Wave({
    required this.power,
    required this.probability,
    required this.surf,
    required this.swells,
    required this.timestamp,
  });

  factory Wave.fromJson(Map<String, dynamic> json) {
    return Wave(
      power: json['power'],
      probability: json['probability'],
      surf: json['surf'],
      swells: json['swells'],
      timestamp: json['timestamp'],
    );
  }

  WaveEntity toWaveEntity() {
    return WaveEntity(
      power: power,
      probability: probability,
      surf: surf.toSurfEntity(),
      swells: swells.map((element) => element.toSwellEntity()).toList(),
      timestamp: timestamp,
      utcOffset: 2,
    );
  }

  @override
  String toString() {
    return 'Wave($timestamp : $power)';
  }
}
