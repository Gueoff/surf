import 'package:surf/src/redux/spot/spot_reducer.dart';

import 'package:surf/src/redux/app_state.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(spotState: spotsReducer(state.spotState, action));
}
