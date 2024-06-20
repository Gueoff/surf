import 'package:flutter/material.dart';
import 'package:surf/src/components/weather_icon.dart';
import 'package:surf/src/models/spot.dart';
import 'package:surf/src/models/forecast.dart';
import 'package:surf/src/models/tide.dart';
import 'package:surf/src/models/water_temperature.dart';
import 'package:surf/src/models/swell.dart';
import 'package:surf/src/screens/spotDetails/components/tide_chart.dart';
import 'package:surf/src/screens/spotDetails/components/timeline_card.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

bool isMidnight(int timestamp) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  return dateTime.hour == 0 && dateTime.minute == 0 && dateTime.second == 0;
}

Widget createForecastShare(Spot spot, List<Forecast> forecasts,
    List<Tide> tides, WaterTemperature waterTemperature) {
  double timelineCardWidth = 88;
  double separatorWidth = 8;
  int intervalHours = 3;
  final dateFormatter = DateFormat('E d/MM', 'fr_FR');

  return Builder(builder: (context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              spot.name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 93, width: 80),
                      SizedBox(
                          height: 80,
                          child: Icon(
                            Icons.cloud,
                            color: Theme.of(context).colorScheme.tertiary,
                            size: 24,
                          )),
                      SizedBox(
                        height: 60,
                        child: Icon(
                          Icons.pin_drop,
                          color: Theme.of(context).colorScheme.tertiary,
                          size: 24,
                        ),
                      ),
                      SizedBox(
                        height: 120,
                        child: Icon(
                          Icons.air,
                          color: Theme.of(context).colorScheme.tertiary,
                          size: 24,
                        ),
                      ),
                      SizedBox(
                        height: 120,
                        child: Icon(
                          Icons.waves,
                          color: Theme.of(context).colorScheme.tertiary,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: forecasts.map((forecast) {
                      SwellElement? swellMain;
                      SwellElement? swellSecondary;

                      try {
                        swellMain = forecast.swell.swells
                            .firstWhere((element) => element.direction != 0);
                      } catch (e) {
                        swellMain = null;
                      }

                      try {
                        swellSecondary = forecast.swell.swells.firstWhere(
                            (element) =>
                                element != swellMain && element.direction != 0);
                      } catch (e) {
                        swellSecondary = null;
                      }

                      return Padding(
                        padding: EdgeInsets.only(right: separatorWidth),
                        child: Container(
                          color: Colors.white,
                          width: timelineCardWidth,
                          child: Column(
                            children: [
                              isMidnight(forecast.rating.timestamp)
                                  ? SizedBox(
                                      height: 40,
                                      child: Text(
                                        dateFormatter.format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                forecast.rating.timestamp *
                                                    1000)),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                    )
                                  : Container(
                                      height: 40,
                                    ),
                              TimelineCard(
                                forecast: forecast,
                                intervalHours: intervalHours,
                              ),

                              // Weather
                              SizedBox(
                                height: 80,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    WeatherIcon(
                                        condition: forecast.weather.condition),
                                    Text(
                                      '${forecast.weather.temperature.round().toString()}°C',
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  ],
                                ),
                              ),

                              // Water
                              SizedBox(
                                height: 60,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('${waterTemperature.min.toString()}°C',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge)
                                  ],
                                ),
                              ),

                              // Wind
                              SizedBox(
                                height: 120,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Transform.rotate(
                                      angle: (forecast.wind.direction - 180) *
                                          (math.pi / 180),
                                      child: Icon(
                                        Icons.arrow_upward,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                        size: 20,
                                      ),
                                    ),
                                    Text(forecast.wind.directionType.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge),
                                    Text(
                                        '${forecast.wind.speed.round().toString()} km/h',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium),
                                  ],
                                ),
                              ),

                              // Waves
                              SizedBox(
                                height: 120,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        '${forecast.surf.min.toString()} - ${forecast.surf.max.toString()}m',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge),
                                    (swellMain != null)
                                        ? Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                  '${swellMain.period.toString()}s',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelLarge),
                                              Transform.rotate(
                                                angle: (swellMain.direction -
                                                        180) *
                                                    (math.pi / 180),
                                                child: Icon(
                                                  Icons.arrow_upward,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .tertiary,
                                                  size: 20,
                                                ),
                                              ),
                                            ],
                                          )
                                        : Container(height: 28),
                                    (swellSecondary != null)
                                        ? Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                  '${swellSecondary.period.toString()}s',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium!
                                                      .copyWith(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .onPrimary)),
                                              Transform.rotate(
                                                angle:
                                                    (swellSecondary.direction -
                                                            180) *
                                                        (math.pi / 180),
                                                child: Icon(
                                                  Icons.arrow_upward,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .tertiary,
                                                  size: 20,
                                                ),
                                              ),
                                            ],
                                          )
                                        : Container(height: 28),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              TideChartStatic(
                intervalHours: intervalHours,
                offset: 120,
                referenceWidth: timelineCardWidth + separatorWidth,
                tides: tides,
              ),
            ],
          ),
        ],
      ),
    );
  });
}
