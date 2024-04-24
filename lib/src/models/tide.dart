import 'package:surf/src/entities/tide_entity.dart';

class Tide {
  double height;
  String type;
  int timestamp;

  Tide({
    required this.height,
    required this.type,
    required this.timestamp,
  });

  factory Tide.fromJson(Map<String, dynamic> json) {
    return Tide(
      height: json['height'],
      type: json['type'],
      timestamp: json['timestamp'],
    );
  }

  TideEntity toTideEntity() {
    return TideEntity(
      height: height,
      type: type,
      timestamp: timestamp,
      utcOffset: 2,
    );
  }

  @override
  String toString() {
    return 'Tide($timestamp : $height)';
  }
}
