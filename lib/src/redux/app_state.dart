import 'package:surf/src/redux/spot/spot_state.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  final SpotState spotState;

  const AppState({
    required this.spotState,
  });

  factory AppState.initial() {
    return AppState(
      spotState: SpotState.initial(),
    );
  }

  AppState copyWith({
    required SpotState spotState,
  }) {
    return AppState(
      spotState: spotState,
    );
  }

  static AppState fromJson(dynamic json) {
    SpotState initSpotState = json == null
        ? SpotState.initial()
        : SpotState.fromJson(json?["spotState"]);
    return AppState(spotState: initSpotState);
  }

  dynamic toJson() {
    return {'spotState': spotState.toJson()};
  }
}
