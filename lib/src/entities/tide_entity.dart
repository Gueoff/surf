import 'package:surf/src/models/tide.dart';

class TideEntity {
  double height;
  String type;
  int timestamp;
  int utcOffset;

  TideEntity({
    required this.height,
    required this.type,
    required this.timestamp,
    required this.utcOffset,
  });

  factory TideEntity.fromJson(Map<String, dynamic> json) {
    return TideEntity(
      height: json['height'].toDouble(),
      type: json['type'],
      timestamp: json['timestamp'],
      utcOffset: json['utcOffset'],
    );
  }

  Tide toTide() {
    return Tide(
      height: height,
      type: type,
      timestamp: timestamp,
    );
  }
}
