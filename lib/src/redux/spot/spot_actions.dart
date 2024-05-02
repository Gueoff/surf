import 'dart:convert';

import 'package:redux/redux.dart';
import 'package:meta/meta.dart';
import 'package:surf/src/models/spot.dart';
import 'package:surf/src/models/status.dart';
import 'package:surf/src/redux/spot/spot_state.dart';
import 'package:surf/src/redux/store.dart';
import 'package:http/http.dart' as http;

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


/*
Future<void> addToFavoritesRequest(Spot spot) async {
  store.dispatch(
    const SetSpotStateAction(
      SpotState(
        status: Status.pending,
        spotFavorites: [spot],
      ),
    ),
  );
}
*/
/*
Future<void> fetchSpotsAction(Store<AppState> store) async {
  store.dispatch(const SetSpotStateAction(
      SpotState(status: Status.pending, spotFavorites: [])));

  try {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    print(response.body);
    assert(response.statusCode == 200);
    final jsonData = json.decode(response.body);
    store.dispatch(
      SetSpotStateAction(
        SpotState(
          status: Status.pending,
          spotFavorites: [],
        ),
      ),
    );
  } catch (error) {
    store.dispatch(SetSpotStateAction(
        SpotState(status: Status.rejected, spotFavorites: [])));
  }
}
*/