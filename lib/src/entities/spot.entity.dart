import 'package:surf/src/entities/location_entity.dart';
import 'package:surf/src/models/spot.dart';

class SpotEntity {
  String? description;
  String image;
  String name;
  LocationEntity? location;
  String surflineUuid;
  String uuid;

  SpotEntity({
    this.description,
    required this.image,
    required this.name,
    this.location,
    required this.surflineUuid,
    required this.uuid,
  });

  factory SpotEntity.fromJson(Map<String, dynamic> json) {
    return SpotEntity(
      description: json['description'],
      image: json['image'],
      name: json['name'],
      location: json['location'] != null
          ? LocationEntity.fromJson(json['location'])
          : null,
      surflineUuid: json['surflineUuid'],
      uuid: json['uuid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'image': image,
      'name': name,
      'location': location,
      'surflineUuid': surflineUuid,
      'uuid': uuid,
    };
  }

  Spot toSpot() {
    return Spot(
      description: description,
      image: image,
      name: name,
      location: location?.toLocation(),
      surflineUuid: surflineUuid,
      uuid: uuid,
    );
  }
}
