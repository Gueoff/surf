import 'package:surf/src/models/location.dart';

class Spot {
  String? description;
  String image;
  String name;
  Location? location;
  String surflineUuid;
  String uuid;

  Spot({
    this.description,
    required this.image,
    required this.name,
    this.location,
    required this.surflineUuid,
    required this.uuid,
  });

  @override
  String toString() {
    return 'Spot($name $uuid)';
  }

  factory Spot.fromJson(Map<String, dynamic> json) {
    return Spot(
      description: json['description'],
      image: json['image'],
      name: json['name'],
      location: Location.fromJson(json['location']),
      surflineUuid: json['surflineUuid'],
      uuid: json['uuid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'image': image,
      'name': name,
      'location': location?.toJson(),
      'surflineUuid': surflineUuid,
      'uuid': uuid,
    };
  }
}
