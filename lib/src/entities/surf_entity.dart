import 'package:surf/src/models/surf.dart';

class RawEntity {
  double min;
  double max;

  RawEntity({required this.min, required this.max});
}

class SurfEntity {
  double? min;
  double? max;
  bool plus;
  String humanRelation;
  // RawEntity raw;
  //int optimalScore;
  int timestamp;
  int utcOffset;

  SurfEntity({
    required this.min,
    required this.max,
    required this.plus,
    required this.humanRelation,
    //required this.raw,
    //required this.optimalScore,
    required this.timestamp,
    required this.utcOffset,
  });

  factory SurfEntity.fromJson(Map<String, dynamic> json) {
    return SurfEntity(
      min: json['surf']['min']?.toDouble(),
      max: json['surf']['max']?.toDouble(),
      plus: json['surf']['plus'],
      humanRelation: json['surf']['humanRelation'],
      //raw: json['raw'],
      //optimalScore: json['surf']['optimalScore'],
      timestamp: json['timestamp'],
      utcOffset: json['utcOffset'],
    );
  }

  Surf toSurf() {
    return Surf(
        min: min,
        max: max,
        plus: plus,
        humanRelation: humanRelation,
        // raw: raw,
        //optimalScore: optimalScore,
        timestamp: timestamp);
  }
}
