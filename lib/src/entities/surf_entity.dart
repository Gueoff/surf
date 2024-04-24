import 'package:surf/src/models/surf.dart';

class RawEntity {
  double min;
  double max;

  RawEntity({required this.min, required this.max});
}

class SurfEntity {
  double min;
  double max;
  bool plus;
  String humanRelation;
  // RawEntity raw;
  int optimalScore;

  SurfEntity({
    required this.min,
    required this.max,
    required this.plus,
    required this.humanRelation,
    //required this.raw,
    required this.optimalScore,
  });

  factory SurfEntity.fromJson(Map<String, dynamic> json) {
    return SurfEntity(
      min: json['min'].toDouble(),
      max: json['max'].toDouble(),
      plus: json['plus'],
      humanRelation: json['humanRelation'],
      //raw: json['raw'],
      optimalScore: json['optimalScore'],
    );
  }

  Surf toSurf() {
    return Surf(
        min: min,
        max: max,
        plus: plus,
        humanRelation: humanRelation,
        // raw: raw,
        optimalScore: optimalScore);
  }
}
