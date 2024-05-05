import 'package:surf/src/models/location.dart';

class LocationEntity {
  double lon;
  double lat;

  LocationEntity({
    required this.lon,
    required this.lat,
  });

  factory LocationEntity.fromJson(Map<String, dynamic> json) {
    return LocationEntity(
      lon: json['lon'],
      lat: json['lat'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lon': lon,
      'lat': lat,
    };
  }

  Location toLocation() {
    return Location(
      longitude: lon,
      latitude: lat,
    );
  }
}
