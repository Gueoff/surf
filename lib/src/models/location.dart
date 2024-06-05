class Location {
  String? city;
  String? country;
  String? department;
  double? latitude;
  double? longitude;
  String? name;
  String? placeId;
  String? postalCode;
  String? region;
  String uuid;

  Location({
    this.city,
    this.country,
    this.department,
    this.latitude,
    this.longitude,
    this.name,
    this.placeId,
    this.postalCode,
    this.region,
    required this.uuid,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      city: json['city'],
      country: json['country'],
      department: json['department'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      name: json['name'],
      placeId: json['placeId'],
      postalCode: json['postalCode'],
      region: json['region'],
      uuid: json['uuid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'country': country,
      'department': department,
      'latitude': latitude,
      'longitude': longitude,
      'name': name,
      'placeId': placeId,
      'postalCode': postalCode,
      'region': region,
      'uuid': uuid,
    };
  }

  @override
  String toString() {
    return '$department, $region';
  }
}
