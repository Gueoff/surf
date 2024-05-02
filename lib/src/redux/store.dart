import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:surf/src/redux/spot/spot_actions.dart';
import 'package:surf/src/redux/spot/spot_reducer.dart';
import 'package:surf/src/redux/spot/spot_state.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:surf/src/redux/app_state.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(spotState: spotsReducer(state.spotState, action));
}



/*
  if (action is SetSpotStateAction) {
    final nextSpotState = spotsReducer(state.spotState, action);

    return state.copyWith(spotState: nextSpotState);
  }

  return state;
}

@immutable
class AppState {
  final SpotState spotState;

  const AppState({
    required this.spotState,
  });

  AppState copyWith({
    required SpotState spotState,
  }) {
    return AppState(
      spotState: spotState ?? this.spotState,
    );
  }
}

class Redux {
  static late Store<AppState> _store;

  static Store<AppState> get store {
    if (_store == null) {
      throw Exception("store is not initialized");
    } else {
      return _store;
    }
  }

  static Future<void> init() async {
    final spotStateInitial = SpotState.initial();

    _store = Store<AppState>(
      appReducer,
      middleware: [thunkMiddleware],
      initialState: AppState(spotState: spotStateInitial),
    );
  }
}*/