import 'package:surf/src/models/sunlight.dart';

class SunlightEntity {
  int midnight;
  int midnightUTCOffset;
  int dawn;
  int dawnUTCOffset;
  int sunrise;
  int sunriseUTCOffset;
  int sunset;
  int sunsetUTCOffset;
  int dusk;
  int duskUTCOffset;

  SunlightEntity({
    required this.midnight,
    required this.midnightUTCOffset,
    required this.dawn,
    required this.dawnUTCOffset,
    required this.sunrise,
    required this.sunriseUTCOffset,
    required this.sunset,
    required this.sunsetUTCOffset,
    required this.dusk,
    required this.duskUTCOffset,
  });

  factory SunlightEntity.fromJson(Map<String, dynamic> json) {
    return SunlightEntity(
      midnight: json['midnight'],
      midnightUTCOffset: json['midnightUTCOffset'],
      dawn: json['dawn'],
      dawnUTCOffset: json['dawnUTCOffset'],
      sunrise: json['sunrise'],
      sunriseUTCOffset: json['sunriseUTCOffset'],
      sunset: json['sunset'],
      sunsetUTCOffset: json['sunsetUTCOffset'],
      dusk: json['dusk'],
      duskUTCOffset: json['duskUTCOffset'],
    );
  }

  Sunlight toSunlight() {
    return Sunlight(
      dawn: dawn,
      dusk: dusk,
    );
  }
}
