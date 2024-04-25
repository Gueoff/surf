import 'package:surf/src/models/water_temperature.dart';

class SpotData {
  String thumbnail;
  List<String> abilityLevels;
  WaterTemperature waterTemp;

  SpotData({
    required this.thumbnail,
    required this.abilityLevels,
    required this.waterTemp,
  });

  factory SpotData.fromJson(Map<String, dynamic> json) {
    return SpotData(
      thumbnail: json['thumbnail'],
      abilityLevels: json['abilityLevels'],
      waterTemp: json['waterTemp'],
    );
  }
}
