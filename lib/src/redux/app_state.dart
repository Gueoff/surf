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
      spotState: spotState ?? this.spotState,
    );
  }

  static AppState fromJson(dynamic json) {
    return AppState(spotState: SpotState.fromJson(json["spotState"]));
  }

  dynamic toJson() {
    return {'spotState': spotState.toJson()};
  }
}
