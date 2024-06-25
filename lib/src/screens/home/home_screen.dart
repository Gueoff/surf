import 'dart:developer';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:surf/src/components/favorite_spot_list.dart';
import 'package:surf/src/components/navbar.dart';
import 'package:surf/src/models/spot.dart';
import 'package:surf/src/redux/app_state.dart';
import 'package:surf/src/redux/spot/spot_view_model.dart';
import 'package:surf/src/screens/spotDetails/spot_details_screen.dart';
import 'package:surf/src/services/api_service.dart';
import 'package:surf/src/components/text_input.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void onNavigateToSpotDetailsSreen(Spot spot) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SpotDetailsScreen(spot: spot)),
    );
  }

  Future<List<Spot>?> onSearch(String value) async {
    final apiService = ApiService();
    try {
      var response = await apiService.searchSpot(value);

      return response;
    } catch (error) {
      log(error.toString());
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawerEnableOpenDragGesture: false,
      drawer: const Navbar(),
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 36,
                height: 36,
                child: GestureDetector(
                  onTap: () => _scaffoldKey.currentState?.openDrawer(),
                  child: SvgPicture.asset(
                    'assets/icons/menu.svg',
                    width: 36,
                    height: 36,
                    semanticsLabel: 'Menu',
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.tertiary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Text(
                AppLocalizations.of(context)!.title,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ],
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.zero,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Text(
                AppLocalizations.of(context)!.subtitle,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ),
        ),
        toolbarHeight: 70,
      ),
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TypeAheadField<Spot>(
              builder: (context, controller, focusNode) {
                return Padding(
                  padding: const EdgeInsets.all(24),
                  child: Textinput(
                    controller: controller,
                    focusNode: focusNode,
                    hintText: AppLocalizations.of(context)!.spots,
                    keyboardType: TextInputType.text,
                    prefixIcon: Icon(Icons.search,
                        size: 24,
                        color: Theme.of(context).colorScheme.tertiary),
                    obscureText: false,
                  ),
                );
              },
              constraints: const BoxConstraints(maxHeight: 220),
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
              itemBuilder: (context, spot) {
                return Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: ListTile(
                    title: Text(spot.name,
                        style: Theme.of(context).textTheme.bodyLarge),
                    subtitle: Text(spot.location!.toString(),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary)),
                  ),
                );
              },
              emptyBuilder: (context) => Center(
                child: Text(AppLocalizations.of(context)!.noResult,
                    style: Theme.of(context).textTheme.bodyLarge),
              ),
              loadingBuilder: (context) => Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              onSelected: (spot) {
                onNavigateToSpotDetailsSreen(spot);
              },
              debounceDuration: const Duration(milliseconds: 800),
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
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: Icon(
                                Icons.bookmark_outline_outlined,
                                color: Theme.of(context).colorScheme.tertiary,
                                size: 20,
                              ),
                            ),
                            Text(AppLocalizations.of(context)!.favorites,
                                style:
                                    Theme.of(context).textTheme.headlineSmall),
                          ],
                        ),
                      ),
                      FavoriteSpotList(spots: viewModel.spots),
                    ]);
              },
            ),
          ],
        ),
      ),
    );
  }
}
