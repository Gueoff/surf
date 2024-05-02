import 'package:redux/redux.dart';
import 'package:surf/src/models/spot.dart';
import 'package:surf/src/redux/app_state.dart';

class SpotViewModel {
  final bool isFavorite;
  final List<Spot> spots;

  SpotViewModel({
    required this.isFavorite,
    required this.spots,
  });

  static SpotViewModel fromStore(Store<AppState> store) {
    return SpotViewModel(
      isFavorite: store.state.spotState.spotFavorites.isNotEmpty,
      spots: store.state.spotState.spotFavorites,
    );
  }
}
