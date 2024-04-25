import 'package:surf/src/entities/surf_entity.dart';

class Raw {
  double min;
  double max;

  Raw({required this.min, required this.max});
}

class Surf {
  double? min;
  double? max;
  bool plus;
  String humanRelation;
  // Raw raw;
  //int optimalScore;
  int timestamp;

  Surf({
    required this.min,
    required this.max,
    required this.plus,
    required this.humanRelation,
    // required this.raw,
    //required this.optimalScore,
    required this.timestamp,
  });

  factory Surf.fromJson(Map<String, dynamic> json) {
    return Surf(
      min: json['min'],
      max: json['max'],
      plus: json['plus'],
      humanRelation: json['humanRelation'],
      // raw: json['raw'],
      //optimalScore: json['optimalScore'],
      timestamp: json['timestamp'],
    );
  }

  SurfEntity toSurfEntity() {
    return SurfEntity(
      min: min,
      max: max,
      plus: plus,
      humanRelation: humanRelation,
      // raw: RawEntity(min: 0.0, max: 0.0),
      //optimalScore: optimalScore,
      timestamp: timestamp,
      utcOffset: 2,
    );
  }

  @override
  String toString() {
    return 'Surf($min / $max)';
  }
}
