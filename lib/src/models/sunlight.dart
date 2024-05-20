class Sunlight {
  int dawn;
  int dusk;

  Sunlight({
    required this.dawn,
    required this.dusk,
  });

  factory Sunlight.fromJson(Map<String, dynamic> json) {
    return Sunlight(
      dawn: json['dawn'],
      dusk: json['dusk'],
    );
  }

  @override
  String toString() {
    return 'Sunlight($dawn : $dusk)';
  }
}
