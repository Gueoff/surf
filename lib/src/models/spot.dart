import 'package:surf/src/models/location.dart';

class Spot {
  String id;
  Location location;
  String name;
  String type;

  Spot(this.id, this.location, this.name, this.type);

  @override
  String toString() {
    return 'Spot($name $id)';
  }
}
