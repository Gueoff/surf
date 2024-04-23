class Location {
  double longitude;
  double latitude;

  Location({
    required this.longitude,
    required this.latitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      longitude: json['lon'],
      latitude: json['lat'],
    );
  }
}
