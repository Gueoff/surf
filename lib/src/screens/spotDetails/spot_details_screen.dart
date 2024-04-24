import 'package:flutter/material.dart';
import 'package:surf/src/models/spot.dart';
import 'package:surf/src/models/forecast.dart';
import 'package:surf/src/models/rating.dart';
import 'package:surf/src/models/tide.dart';
import 'package:surf/src/models/wave.dart';
import 'package:surf/src/models/weather.dart';
import 'package:surf/src/models/wind.dart';
import 'package:surf/src/screens/spotDetails/detail_silver.dart';
import 'package:surf/src/screens/spotDetails/timeline_card.dart';
import 'package:surf/src/screens/spotDetails/wave_card.dart';
import 'package:surf/src/screens/spotDetails/wind_card.dart';
import 'package:surf/src/screens/spotDetails/weather_card.dart';
import 'package:surf/src/services/api_service.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

List<Forecast> groupEntitiesByTimestamp(
    List<Rating> ratingEntities,
    List<Tide> tideEntities,
    List<Wave> waveEntities,
    List<Weather> weatherEntities,
    List<Wind> windEntities) {
  List<Forecast> forecastList = [];

  for (int i = 0; i < ratingEntities.length; i++) {
    Rating ratingEntity = ratingEntities[i];
    int timestamp = ratingEntity.timestamp;

    print('ok');

    if (i % 3 == 0) {
      Tide matchingTide =
          tideEntities.firstWhere((element) => element.timestamp == timestamp);
      Wave matchingWave =
          waveEntities.firstWhere((element) => element.timestamp == timestamp);
      Weather matchingWeather = weatherEntities
          .firstWhere((element) => element.timestamp == timestamp);
      Wind matchingWind =
          windEntities.firstWhere((element) => element.timestamp == timestamp);

      // Create a new Forecast entity and add it to the list
      forecastList.add(Forecast.groupModels(ratingEntity, matchingTide,
          matchingWave, matchingWeather, matchingWind));
    }
  }

  return forecastList;
}

double timelineCardWidth = 200;

class SpotDetailsScreen extends StatefulWidget {
  final Spot spot;

  const SpotDetailsScreen({super.key, required this.spot});

  @override
  State<SpotDetailsScreen> createState() => _SpotDetailsScreenState();
}

class _SpotDetailsScreenState extends State<SpotDetailsScreen> {
  Forecast? selectedForecast;
  late ScrollController _scrollController;
  final dateFormatter = DateFormat.yMMMMd();
  final timeFormatter = DateFormat.Hm();
  late Future<List<Forecast>> future;
  get offset => _scrollController.hasClients ? _scrollController.offset : 0;
  late List<Forecast> forecastData;
  DateTime currentDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(onScroll);
    future = onGetSpotForecasts(widget.spot.id);
  }

  /// Get the spot forecast.
  Future<List<Forecast>> onGetSpotForecasts(String spotId) async {
    final apiService = ApiService();
    late List<Rating> responseRating;
    late List<Tide> responseTide;
    late List<Wave> responseWave;
    late List<Weather> responseWeather;
    late List<Wind> responseWind;

    try {
      await Future.wait<void>([
        (() async => responseRating = await apiService.getSpotRating(spotId))(),
        (() async => responseTide = await apiService.getSpotTides(spotId))(),
        (() async => responseWave = await apiService.getSpotWaves(spotId))(),
        (() async =>
            responseWeather = await apiService.getSpotWeather(spotId))(),
        (() async => responseWind = await apiService.getSpotWind(spotId))(),
      ]);

      forecastData = groupEntitiesByTimestamp(responseRating, responseTide,
          responseWave, responseWeather, responseWind);

      return forecastData;
    } catch (error) {
      print(error);
    }

    return [];
  }

  /// Select a forecast in the list
  void onPressForecast(Forecast forecast) {
    setState(() {
      selectedForecast = forecast;
    });
  }

  /// Scroll horizontal event
  onScroll() {
    // Update the current date.
    final index = (_scrollController.offset / (timelineCardWidth + 24)).round();
    final forecast = forecastData[index];
    setState(() {
      currentDate =
          DateTime.fromMillisecondsSinceEpoch(forecast.timestamp * 1000);
    });
  }

  /// Scroll to the current time.
  void _scrollToCurrentDate() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        120 * 24, // Adjust the value based on the item height
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
/*
      var currentDate = DateTime.now();
      for (int i = 0; i < ratingList.length; i++) {
        var ratingDate =
            DateTime.fromMillisecondsSinceEpoch(ratingList[i].timestamp * 1000);
        if (ratingDate.year == currentDate.year &&
            ratingDate.month == currentDate.month &&
            ratingDate.day == currentDate.day) {
          _scrollController.animateTo(
            i * 70.0, // Adjust the value based on the item height
            duration: Duration(seconds: 1),
            curve: Curves.easeInOut,
          );
          break;
        }
      }*/
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: DetailSliverDelegate(
              spot: widget.spot,
              expandedHeight: 360,
              roundedContainerHeight: 40,
            ),
          ),
          SliverToBoxAdapter(
            child: FutureBuilder(
                future: future,
                builder: (context, snapshot) {
                  return snapshot.connectionState == ConnectionState.waiting
                      ? Padding(
                          padding: const EdgeInsets.all(24),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Theme.of(context).colorScheme.secondary,
                              backgroundColor: Colors.white,
                            ),
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 24, right: 24),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(dateFormatter.format(currentDate),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
                                  FilledButton(
                                    style: FilledButton.styleFrom(
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(14)),
                                      ),
                                    ),
                                    onPressed: () {
                                      _scrollToCurrentDate();
                                    },
                                    child: Text('Now',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 20),
                              height: 150,
                              child: ListView.separated(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                ),
                                controller: _scrollController,
                                itemBuilder: (BuildContext context, int index) {
                                  final forecast = snapshot.data![index];

                                  return Column(
                                    children: [
                                      SizedBox(
                                        width: timelineCardWidth,
                                        child: TimelineCard(
                                            forecast: forecast,
                                            onCardTap: onPressForecast),
                                      )
                                    ],
                                  );
                                },
                                itemCount: snapshot.data!.length,
                                separatorBuilder: (context, index) =>
                                    const VerticalDivider(
                                  width: 12,
                                  thickness: 2,
                                  color: Colors.white,
                                ),
                                scrollDirection: Axis.horizontal,
                              ),
                            ),
                            if (selectedForecast != null)
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(24),
                                    child:
                                        WindCard(wind: selectedForecast!.wind),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 24),
                                        child: WeatherCard(
                                            weather: selectedForecast!.weather),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 24),
                                        child: WaveCard(
                                            wave: selectedForecast!.wave),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            AnimatedBuilder(
                              animation: _scrollController,
                              builder: (BuildContext context, Widget? child) {
                                return SizedBox(
                                  width: 200, // Specify a width here
                                  height: 200, // Specify a height here
                                  child: OverflowBox(
                                    maxWidth: double.infinity,
                                    alignment: const Alignment(4, 3),
                                    child: Transform.rotate(
                                      angle: ((math.pi * offset) / -1024),
                                      child: const Icon(Icons.settings,
                                          size: 48, color: Colors.red),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                }),
          )
        ],
      ),
    );
  }
}
