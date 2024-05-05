import 'package:meta/meta.dart';
import 'package:surf/src/models/spot.dart';
import 'package:surf/src/models/status.dart';
import 'package:surf/src/redux/spot/spot_actions.dart';

@immutable
class SpotState {
  final Status status;
  final List<Spot> spotFavorites;

  const SpotState({
    this.status = Status.idle,
    this.spotFavorites = const [],
  });

  factory SpotState.initial() => const SpotState(
        status: Status.idle,
        spotFavorites: [],
      );

  SpotState copyWith({
    Status? status,
    List<Spot>? spotFavorites,
  }) {
    return SpotState(
      status: status ?? this.status,
      spotFavorites: spotFavorites ?? this.spotFavorites,
    );
  }

  static SpotState fromJson(dynamic json) {
    return SpotState(
      status: Status.idle,
      spotFavorites: json["spotFavorites"] != null
          ? List<Spot>.from(json["spotFavorites"].map((x) => Spot.fromJson(x)))
          : [],
    );
  }

  dynamic toJson() {
    return {
      'status': status.toString(),
      'spotFavorites': spotFavorites.map((spot) => spot.toJson()).toList(),
    };
  }

  SpotState spotReducer(SpotState state, dynamic action) {
    if (action is AddSpotAction) {
      return state.copyWith(
        spotFavorites: List.of(state.spotFavorites)..add(action.spot),
      );
    }
    return state;
  }
}
