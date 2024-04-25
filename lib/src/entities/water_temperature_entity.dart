import 'package:surf/src/models/water_temperature.dart';

class WaterTemperatureEntity {
  int min;
  int max;

  WaterTemperatureEntity({
    required this.min,
    required this.max,
  });

  factory WaterTemperatureEntity.fromJson(Map<String, dynamic> json) {
    return WaterTemperatureEntity(
      min: json['waterTemp']['min'],
      max: json['waterTemp']['max'],
    );
  }

  WaterTemperature toWaterTemperature() {
    return WaterTemperature(
      min: min,
      max: max,
    );
  }
}
