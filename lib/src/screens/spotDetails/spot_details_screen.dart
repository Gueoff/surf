import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:surf/src/components/button_toggle.dart';
import 'package:surf/src/components/forecast_rating_indicator.dart';
import 'package:surf/src/components/forecast_share.dart';
import 'package:surf/src/models/spot.dart';
import 'package:surf/src/models/forecast.dart';
import 'package:surf/src/models/rating.dart';
import 'package:surf/src/models/spot_weather_response.dart';
import 'package:surf/src/models/sunlight.dart';
import 'package:surf/src/models/tide.dart';
import 'package:surf/src/models/water_temperature.dart';
import 'package:surf/src/models/surf.dart';
import 'package:surf/src/models/swell.dart';
import 'package:surf/src/models/weather.dart';
import 'package:surf/src/models/wind.dart';
import 'package:surf/src/screens/spotDetails/components/detail_silver.dart';
import 'package:surf/src/screens/spotDetails/components/sunlight_card.dart';
import 'package:surf/src/screens/spotDetails/components/tide_chart.dart';
import 'package:surf/src/screens/spotDetails/components/timeline_card.dart';
import 'package:surf/src/screens/spotDetails/components/water_temperature_card.dart';
import 'package:surf/src/screens/spotDetails/components/wave_card.dart';
import 'package:surf/src/screens/spotDetails/components/wind_card.dart';
import 'package:surf/src/screens/spotDetails/components/weather_card.dart';
import 'package:surf/src/services/api_service.dart';
import 'package:intl/intl.dart';
import 'dart:typed_data';
import 'package:share_plus/share_plus.dart';

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
      return midIndex;
    }
  }

  // Comparer les deux dates les plus proches de la date actuelle.
  var beforeDate = forecastData[maxIndex].timestamp;
  var afterDate = forecastData[minIndex].timestamp;

  var beforeDifference = timestamp - beforeDate;
  var afterDifference = afterDate - timestamp;
  return (beforeDifference <= afterDifference) ? maxIndex : minIndex;
}

Sunlight? getSunlight(List<Sunlight> sunlights, Forecast forecast) {
  DateTime originalDateTime =
      DateTime.fromMillisecondsSinceEpoch(forecast.timestamp * 1000);

  try {
    return sunlights.firstWhere((element) {
      DateTime dawn = DateTime.fromMillisecondsSinceEpoch(element.dawn * 1000);
      DateTime dusk = DateTime.fromMillisecondsSinceEpoch(element.dusk * 1000);

      return dawn.day == originalDateTime.day ||
          dusk.day == originalDateTime.day;
    });
  } catch (e) {
    log(e.toString());
  }

  return null;
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
  DateTime currentDate = DateTime.now();
  ScreenshotController screenshotController = ScreenshotController();
  double screenWidth = 0.0;
  int intervalHours = 3;
  late ScrollController _scrollController;
  late List<Forecast> forecastData;
  late WaterTemperature waterTemperature;
  late List<Tide> tides;
  late List<Sunlight> sunlights;
  late Future<List<Forecast>> future;
  final apiService = ApiService();
  final GlobalKey globalKey = GlobalKey();
  final dateFormatter = DateFormat('E d/MM', 'fr_FR');
  final timeFormatter = DateFormat.Hm();

  get offset => _scrollController.hasClients ? _scrollController.offset : 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(onScroll);
    future = onGetSpotForecasts(widget.spot.surflineUuid).then((_) {
      _scrollToDate(DateTime.now());
      return _;
    });
  }

  // Get the spot forecast.
  Future<List<Forecast>> onGetSpotForecasts(String spotId) async {
    late List<Rating> responseRating;
    late List<Surf> responseSurf;
    late List<Swell> responseSwell;
    late List<Tide> responseTide;
    late SpotWeatherResponse responseWeather;
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
          responseSwell, responseTide, responseWeather.weather, responseWind);

      setState(() {
        sunlights = responseWeather.sunlight;
        tides = responseTide.where((tide) => tide.type != 'NORMAL').toList();
        waterTemperature = responseWaterTemperature;
      });

      return forecastData;
    } catch (error) {
      log(error.toString());
    }

    return [];
  }

  // Select a forecast in the list
  void onPressForecast(Forecast forecast) {
    var index = findNearestIndex(forecastData, forecast.timestamp.toDouble());
    _scrollTo(index);

    setState(() {
      selectedForecast = forecast;
    });
  }

  Future<void> onShareForecast(BuildContext context) async {
    Uint8List? image = await screenshotController.captureFromLongWidget(
      InheritedTheme.captureAll(
        context,
        Material(
          child: createForecastShare(
              widget.spot, forecastData, tides, waterTemperature),
        ),
      ),
      delay: const Duration(milliseconds: 100),
      context: context,
    );

    final directory = await getApplicationDocumentsDirectory();
    final imagePath = await File('${directory.path}/image.png').create();
    await imagePath.writeAsBytes(image);

    print(imagePath);

    await Share.shareXFiles([XFile(imagePath.path)],
        text: 'Regarde moi ces conditions!',
        subject: 'Conditions de surf à ${widget.spot.name}',
        sharePositionOrigin: Rect.fromLTWH(
            0,
            0,
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height / 2));
  }

  // Scroll horizontal event
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

  // Get the current time in the timeline.
  DateTime getCurrentTime() {
    double hours = (offset + separatorWidth / 2) /
        (timelineCardWidth + separatorWidth) *
        intervalHours;
    int totalSeconds = (hours * 3600).toInt();
    int roundedHour = ((totalSeconds ~/ 3600 / 1).round() * 1).toInt();
    DateTime now = DateTime.now();
    DateTime startTime = DateTime(now.year, now.month, now.day, 0, 0, 0);
    DateTime exactTime =
        startTime.add(Duration(hours: roundedHour, minutes: 0));

    return exactTime;
  }

  // Change the interval hours.
  onSetInterval(int value) {
    if (value != intervalHours) {
      DateTime current = getCurrentTime();
      apiService.setIntervalHours(value);

      future = onGetSpotForecasts(widget.spot.surflineUuid).then((_) {
        _scrollToDate(current);
        return _;
      });

      setState(() {
        intervalHours = value;
      });
    }
  }

  // Scroll to the current time.
  void _scrollToDate(DateTime date) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var index =
          findNearestIndex(forecastData, date.millisecondsSinceEpoch / 1000);
      _scrollTo(index);
    });
  }

  // Scroll to an index in the timeline.
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

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: DetailSliverDelegate(
              expandedHeight: 360,
              onShare: () => onShareForecast(context),
              roundedContainerHeight: 40,
              spot: widget.spot,
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 24, bottom: 12),
                    child: ButtonsToggle(
                      onTap: onSetInterval,
                      value: intervalHours,
                      options: const [1, 3, 6, 12],
                    ),
                  ),
                ),
                FutureBuilder(
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
                                padding: const EdgeInsets.only(
                                    left: 24, right: 24, bottom: 4),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                          dateFormatter.format(currentDate),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: selectedForecast != null
                                          ? Text(
                                              timeFormatter
                                                  .format(getCurrentTime()),
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
                                                horizontal: 0),
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(14)),
                                            ),
                                          ),
                                          onPressed: () {
                                            _scrollToDate(DateTime.now());
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
                                alignment: Alignment.bottomRight,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 12, top: 4),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 120,
                                          child: ListView.separated(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: screenWidth / 2,
                                            ),
                                            controller: _scrollController,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              final forecast =
                                                  snapshot.data![index];

                                              return Column(
                                                children: [
                                                  SizedBox(
                                                    width: timelineCardWidth,
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  bottom: 4),
                                                          child: ForecastRatingIndicator(
                                                              ratingValue:
                                                                  forecast
                                                                      .rating
                                                                      .value),
                                                        ),
                                                        TimelineCard(
                                                            intervalHours:
                                                                intervalHours,
                                                            forecast: forecast,
                                                            onCardTap:
                                                                onPressForecast),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              );
                                            },
                                            itemCount: snapshot.data!.length,
                                            separatorBuilder:
                                                (context, index) =>
                                                    VerticalDivider(
                                              width: separatorWidth,
                                              thickness: 2,
                                              color: Colors.transparent,
                                            ),
                                            scrollDirection: Axis.horizontal,
                                          ),
                                        ),
                                        TideChart(
                                          animation: _scrollController,
                                          intervalHours: intervalHours,
                                          referenceWidth: timelineCardWidth +
                                              separatorWidth,
                                          tides: tides,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    left: screenWidth / 2,
                                    top: 0,
                                    child: Opacity(
                                      opacity: 0.5,
                                      child: Container(
                                        width: 1,
                                        height: 230,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
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
                                                weather:
                                                    selectedForecast!.weather),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 6, right: 24, bottom: 12),
                                            child: WaterTemperatureCard(
                                                waterTemperature:
                                                    waterTemperature),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 24, right: 24, bottom: 12),
                                      child: WindCard(
                                          wind: selectedForecast!.wind),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 24, right: 24, bottom: 12),
                                      child: WaveCard(
                                        surf: selectedForecast!.surf,
                                        swell: selectedForecast!.swell,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 24, right: 24, bottom: 32),
                                      child: SunlightCard(
                                        sunlight: getSunlight(
                                            sunlights, selectedForecast!)!,
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
