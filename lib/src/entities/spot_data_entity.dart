import 'package:surf/src/entities/water_temperature_entity.dart';

class SpotDataEntity {
  String thumbnail;
  List<String> abilityLevels;
  WaterTemperatureEntity waterTemp;

  SpotDataEntity({
    required this.thumbnail,
    required this.abilityLevels,
    required this.waterTemp,
  });

  factory SpotDataEntity.fromJson(Map<String, dynamic> json) {
    return SpotDataEntity(
      thumbnail: json['thumbnail'],
      abilityLevels: json['abilityLevels'],
      waterTemp: json['waterTemp'],
    );
  }
}
