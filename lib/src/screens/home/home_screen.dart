import 'package:flutter_redux/flutter_redux.dart';
import 'package:surf/src/components/favorite_spot_list.dart';
import 'package:surf/src/components/header.dart';
import 'package:surf/src/models/spot.dart';
import 'package:surf/src/models/suggest_option.dart';
import 'package:surf/src/redux/app_state.dart';
import 'package:surf/src/redux/spot/spot_view_model.dart';
import 'package:surf/src/screens/spotDetails/spot_details_screen.dart';
import 'package:surf/src/services/api_service.dart';
import 'package:surf/src/components/text_input.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void onNavigateToSpotDetailsSreen(SuggestOption suggestOption) {
    Spot spot = Spot(
        id: suggestOption.id,
        address: suggestOption.source.address,
        location: suggestOption.source.location,
        name: suggestOption.source.name,
        type: suggestOption.type);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SpotDetailsScreen(spot: spot)),
    );
  }

  Future<List<SuggestOption>?> onSearch(String value) async {
    final apiService = ApiService();
    try {
      var response = await apiService.searchSpot(value);

      return response;
    } catch (error) {
      print(error);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Header(
            title: 'Welcome man',
            subtitle: 'Trouve ton spot',
          ),
          TypeAheadField<SuggestOption>(
            builder: (context, controller, focusNode) {
              return Padding(
                padding: const EdgeInsets.all(24),
                child: Textinput(
                  controller: controller,
                  focusNode: focusNode,
                  hintText: 'Location',
                  keyboardType: TextInputType.text,
                  prefixIcon: Icon(Icons.search,
                      color: Theme.of(context).colorScheme.tertiary),
                  obscureText: false,
                ),
              );
            },
            constraints: const BoxConstraints(maxHeight: 200),
            decorationBuilder: (context, child) {
              return Material(
                type: MaterialType.card,
                elevation: 8,
                shadowColor: const Color.fromRGBO(97, 216, 240, 0.2),
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                child: child,
              );
            },
            hideOnEmpty: false,
            hideOnUnfocus: true,
            hideWithKeyboard: true,
            itemBuilder: (context, suggestOption) {
              return ListTile(
                title: Text(suggestOption.text),
                subtitle: Text(suggestOption.source.address),
              );
            },
            emptyBuilder: (context) => Center(
              child: Text('Pas de résultat',
                  style: Theme.of(context).textTheme.labelMedium),
            ),
            loadingBuilder: (context) => Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            onSelected: (suggestOption) {
              onNavigateToSpotDetailsSreen(suggestOption);
            },
            suggestionsCallback: (pattern) async {
              return await onSearch(pattern);
            },
          ),
          StoreConnector<AppState, SpotViewModel>(
            converter: (store) => SpotViewModel.fromStore(store),
            builder: (context, viewModel) {
              if (viewModel.spots.isEmpty) {
                return const SizedBox.shrink();
              }

              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text('Mes favoris',
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                    FavoriteSpotList(spots: viewModel.spots),
                  ]);
            },
          ),
        ],
      ),
    );
  }
}
