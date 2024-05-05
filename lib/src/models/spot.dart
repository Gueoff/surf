import 'package:surf/src/models/location.dart';

class Spot {
  String address;
  String id;
  Location location;
  String name;
  String type;

  Spot(
      {required this.id,
      required this.location,
      required this.name,
      required this.type,
      required this.address});

  @override
  String toString() {
    return 'Spot($name $id)';
  }

  factory Spot.fromJson(Map<String, dynamic> json) {
    return Spot(
      address: json['address'],
      id: json['id'],
      location: Location.fromJson(json['location']),
      name: json['name'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'id': id,
      'location': location.toJson(),
      'name': name,
      'type': type,
    };
  }
}
