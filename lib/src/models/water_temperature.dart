import 'package:surf/src/entities/water_temperature_entity.dart';

class WaterTemperature {
  int min;
  int max;

  WaterTemperature({
    required this.min,
    required this.max,
  });

  WaterTemperatureEntity toWaterTemperatureEntity() {
    return WaterTemperatureEntity(
      min: min,
      max: max,
    );
  }

  @override
  String toString() {
    return 'WaterTemperature($min : $max)';
  }
}
