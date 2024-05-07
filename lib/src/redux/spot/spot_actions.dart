import 'package:meta/meta.dart';
import 'package:surf/src/models/spot.dart';

import 'package:surf/src/redux/spot/spot_state.dart';

@immutable
class SetSpotStateAction {
  final SpotState spotState;

  const SetSpotStateAction(this.spotState);
}

class AddSpotAction {
  final Spot spot;

  AddSpotAction(this.spot);
}

class RemoveSpotAction {
  final Spot spot;

  RemoveSpotAction(this.spot);
}
