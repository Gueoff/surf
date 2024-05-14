import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:surf/src/components/forecast_rating_indicator.dart';
import 'package:surf/src/models/spot.dart';
import 'package:surf/src/models/forecast.dart';
import 'package:surf/src/models/rating.dart';
import 'package:surf/src/models/tide.dart';
import 'package:surf/src/models/water_temperature.dart';
import 'package:surf/src/models/surf.dart';
import 'package:surf/src/models/swell.dart';
import 'package:surf/src/models/weather.dart';
import 'package:surf/src/models/wind.dart';
import 'package:surf/src/screens/spotDetails/detail_silver.dart';
import 'package:surf/src/screens/spotDetails/tide_card.dart';
import 'package:surf/src/screens/spotDetails/timeline_card.dart';
import 'package:surf/src/screens/spotDetails/water_temperature_card.dart';
import 'package:surf/src/screens/spotDetails/wave_card.dart';
import 'package:surf/src/screens/spotDetails/wind_card.dart';
import 'package:surf/src/screens/spotDetails/weather_card.dart';
import 'package:surf/src/services/api_service.dart';
import 'package:intl/intl.dart';

List<Forecast> groupEntitiesByTimestamp(
    List<Rating> ratingEntities,
    List<Surf> surfEntities,
    List<Swell> swellEntities,
    List<Tide> tideEntities,
    List<Weather> weatherEntities,
    List<Wind> windEntities) {
  List<Forecast> forecastList = [];

  for (var ratingEntity in ratingEntities) {
    int timestamp = ratingEntity.timestamp;

    Tide matchingTide =
        tideEntities.firstWhere((element) => element.timestamp == timestamp);
    Surf matchingSurf =
        surfEntities.firstWhere((element) => element.timestamp == timestamp);
    Swell matchingSwell =
        swellEntities.firstWhere((element) => element.timestamp == timestamp);
    Weather matchingWeather =
        weatherEntities.firstWhere((element) => element.timestamp == timestamp);
    Wind matchingWind =
        windEntities.firstWhere((element) => element.timestamp == timestamp);

    // Create a new Forecast entity and add it to the list
    forecastList.add(Forecast.groupModels(ratingEntity, matchingSurf,
        matchingSwell, matchingTide, matchingWeather, matchingWind));
  }

  return forecastList;
}

// Trouver l'indice de l'élément le plus proche de la date actuelle.
int findNearestIndex(List<Forecast> forecastData, double timestamp) {
  int minIndex = 0;
  int maxIndex = forecastData.length - 1;
  if (timestamp < forecastData[minIndex].timestamp) {
    return minIndex;
  }
  if (timestamp > forecastData[maxIndex].timestamp) {
    return maxIndex;
  }

  // Recherche binaire pour trouver l'indice le plus proche de la date actuelle.
  while (minIndex <= maxIndex) {
    int midIndex = (minIndex + maxIndex) ~/ 2;
    var midDate = forecastData[midIndex].timestamp;

    if (midDate < timestamp) {
      minIndex = midIndex + 1;
    } else if (midDate > timestamp) {
      maxIndex = midIndex - 1;
    } else {
      return midIndex; // Date exacte trouvée.
    }
  }

  // Comparer les deux dates les plus proches de la date actuelle.
  var beforeDate = forecastData[maxIndex].timestamp;
  var afterDate = forecastData[minIndex].timestamp;

  var beforeDifference = timestamp - beforeDate;
  var afterDifference = afterDate - timestamp;
  return (beforeDifference <= afterDifference) ? maxIndex : minIndex;
}

double timelineCardWidth = 68;
double separatorWidth = 4;

class SpotDetailsScreen extends StatefulWidget {
  final Spot spot;

  const SpotDetailsScreen({super.key, required this.spot});

  @override
  State<SpotDetailsScreen> createState() => _SpotDetailsScreenState();
}

class _SpotDetailsScreenState extends State<SpotDetailsScreen> {
  Forecast? selectedForecast;
  late ScrollController _scrollController;
  final dateFormatter = DateFormat('E d/MM', 'fr_FR');
  final timeFormatter = DateFormat.Hm();
  late Future<List<Forecast>> future;
  get offset => _scrollController.hasClients ? _scrollController.offset : 0;
  late List<Forecast> forecastData;
  DateTime currentDate = DateTime.now();
  late WaterTemperature waterTemperature;
  late List<Tide> tides;
  double screenWidth = 0.0;

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
    late List<Surf> responseSurf;
    late List<Swell> responseSwell;
    late List<Tide> responseTide;
    late List<Weather> responseWeather;
    late List<Wind> responseWind;
    late WaterTemperature responseWaterTemperature;

    try {
      await Future.wait<void>([
        (() async => responseRating = await apiService.getSpotRating(spotId))(),
        (() async => responseTide = await apiService.getSpotTides(spotId))(),
        (() async => responseSurf = await apiService.getSpotSurf(spotId))(),
        (() async => responseSwell = await apiService.getSpotSwells(spotId))(),
        (() async =>
            responseWeather = await apiService.getSpotWeather(spotId))(),
        (() async => responseWind = await apiService.getSpotWind(spotId))(),
        (() async => responseWaterTemperature =
            await apiService.getSpotWaterTemperature(spotId))(),
      ]);

      forecastData = groupEntitiesByTimestamp(responseRating, responseSurf,
          responseSwell, responseTide, responseWeather, responseWind);

      setState(() {
        waterTemperature = responseWaterTemperature;
        tides = responseTide.where((tide) => tide.type != 'NORMAL').toList();
      });

      _scrollToCurrentDate();
      return forecastData;
    } catch (error) {
      log(error.toString());
    }

    return [];
  }

  /// Select a forecast in the list
  void onPressForecast(Forecast forecast) {
    var index = findNearestIndex(forecastData, forecast.timestamp.toDouble());
    _scrollTo(index);

    setState(() {
      selectedForecast = forecast;
    });
  }

  /// Scroll horizontal event
  onScroll() {
    final itemWidth = timelineCardWidth + separatorWidth;
    final middlePosition = _scrollController.offset + separatorWidth / 2;

    int index = (middlePosition / itemWidth).floor();
    final forecast = forecastData[index];

    if (index >= 0 && index < forecastData.length) {
      setState(() {
        selectedForecast = forecast;
        currentDate =
            DateTime.fromMillisecondsSinceEpoch(forecast.timestamp * 1000);
      });
    }
  }

  /// Scroll to the current time.
  void _scrollToCurrentDate() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var currentDate = DateTime.now().millisecondsSinceEpoch / 1000;

      var index = findNearestIndex(forecastData, currentDate);
      _scrollTo(index);
    });
  }

  void _scrollTo(int index) {
    _scrollController.animateTo(
      index * (timelineCardWidth + separatorWidth) + timelineCardWidth / 2,
      duration: const Duration(milliseconds: 800),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    // print(screenWidth); // 411

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: DetailSliverDelegate(
              expandedHeight: 360,
              roundedContainerHeight: 40,
              spot: widget.spot,
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
                            padding: const EdgeInsets.only(left: 24, right: 24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(dateFormatter.format(currentDate),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: selectedForecast != null
                                      ? Text(
                                          timeFormatter.format(DateTime
                                              .fromMillisecondsSinceEpoch(
                                                  selectedForecast!.timestamp *
                                                      1000)),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                          textAlign: TextAlign.center,
                                        )
                                      : Container(),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.topRight,
                                    child: FilledButton(
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
                                      child: Icon(
                                        Icons.schedule,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondary,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 20),
                                height: 150,
                                child: ListView.separated(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth / 2,
                                  ),
                                  controller: _scrollController,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final forecast = snapshot.data![index];

                                    return Column(
                                      children: [
                                        SizedBox(
                                          width: timelineCardWidth,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 4),
                                                child: ForecastRatingIndicator(
                                                    ratingValue:
                                                        forecast.rating.value),
                                              ),
                                              TimelineCard(
                                                  forecast: forecast,
                                                  onCardTap: onPressForecast),
                                            ],
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                  itemCount: snapshot.data!.length,
                                  separatorBuilder: (context, index) =>
                                      VerticalDivider(
                                    width: separatorWidth,
                                    thickness: 2,
                                    color: Colors.transparent,
                                  ),
                                  scrollDirection: Axis.horizontal,
                                ),
                              ),
                              Positioned(
                                left: screenWidth / 2,
                                top: 0,
                                child: Container(
                                  width: 1,
                                  height: 200,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                          TideCard(
                            animation: _scrollController,
                            tides: tides,
                          ),
                          if (selectedForecast != null)
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 24, right: 6, bottom: 12),
                                        child: WeatherCard(
                                            weather: selectedForecast!.weather),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 6, right: 24, bottom: 12),
                                        child: WaterTemperatureCard(
                                            waterTemperature: waterTemperature),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 24, right: 24, bottom: 12),
                                  child: WindCard(wind: selectedForecast!.wind),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 24, right: 24, bottom: 12),
                                  child: WaveCard(
                                    surf: selectedForecast!.surf,
                                    swell: selectedForecast!.swell,
                                  ),
                                ),
                              ],
                            ),
                          AnimatedBuilder(
                            animation: _scrollController,
                            builder: (BuildContext context, Widget? child) {
                              var offsetTmp = offset / 4;
                              return SizedBox(
                                width: 36, // Specify a width here
                                height: 36, // Specify a height here
                                child: OverflowBox(
                                  maxWidth: double.infinity,
                                  alignment: const Alignment(4, 3),
                                  child: Transform.translate(
                                    offset: Offset(
                                        0, offsetTmp <= 20 ? -offsetTmp : -20),

                                    // angle: ((math.pi * offset) / -1024),
                                    child: SvgPicture.asset(
                                        'assets/icons/weather/clear-day.svg',
                                        width: 36,
                                        height: 36,
                                        semanticsLabel: 'Meteo'),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      );
              },
            ),
          )
        ],
      ),
    );
  }
}
