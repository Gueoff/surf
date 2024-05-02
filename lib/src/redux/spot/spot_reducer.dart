import 'package:redux/redux.dart';
import 'package:surf/src/models/status.dart';
import 'package:surf/src/redux/spot/spot_actions.dart';
import 'package:surf/src/redux/spot/spot_state.dart';

/*
spotsReducer(SpotState prevState, SetSpotStateAction action) {
  final payload = action.spotState;

  return prevState.copyWith(
    status: payload.status,
    spotFavorites: payload.spotFavorites,
  );
}*/

final spotsReducer = combineReducers<SpotState>([
  TypedReducer<SpotState, AddSpotAction>(_addSpot).call,
  TypedReducer<SpotState, RemoveSpotAction>(_removeSpot).call,
]);

SpotState _addSpot(SpotState prevState, AddSpotAction action) {
  final payload = action.spot;

  return prevState.copyWith(
    status: Status.pending,
    spotFavorites: List.from(prevState.spotFavorites)..add(payload),
  );
}

SpotState _removeSpot(SpotState prevState, RemoveSpotAction action) {
  final payload = action.spot;

  return prevState.copyWith(
    status: Status.pending,
    spotFavorites: prevState.spotFavorites..remove(payload),
  );
}
