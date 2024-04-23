import 'package:flutter/material.dart';
import 'package:surf/src/models/Spot.dart';
import 'package:surf/src/models/forecast.dart';
import 'package:surf/src/models/rating.dart';
import 'package:surf/src/models/wind.dart';
import 'package:surf/src/screens/spotDetails/detail_silver.dart';
import 'package:surf/src/screens/spotDetails/timeline_card.dart';
import 'package:surf/src/services/api_service.dart';
import 'package:intl/intl.dart';

List<Forecast> groupEntitiesByTimestamp(
    List<Rating> ratingEntities, List<Wind> windEntities) {
  List<Forecast> forecastList = [];

  for (Rating ratingEntity in ratingEntities) {
    int timestamp = ratingEntity.timestamp;

    // Find the corresponding wind entity for the current timestamp
    Wind matchingWind =
        windEntities.firstWhere((wind) => wind.timestamp == timestamp);

    // Create a new Forecast entity and add it to the list
    forecastList.add(Forecast.groupModels(ratingEntity, matchingWind));
  }

  return forecastList;
}

class SpotDetailsScreen extends StatefulWidget {
  final Spot spot;

  const SpotDetailsScreen({super.key, required this.spot});

  @override
  State<SpotDetailsScreen> createState() => _SpotDetailsScreenState();
}

class _SpotDetailsScreenState extends State<SpotDetailsScreen> {
  List<Forecast> forecastList = [];
  late ScrollController _scrollController;
  final dateFormatter = DateFormat.yMMMMd();
  final timeFormatter = DateFormat.Hm();

  @override
  SpotDetailsScreen get widget => super.widget;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _onGetSpotForecasts(widget.spot.id);
    });
  }

/**
 * Get the spot forecast.
 */
  void _onGetSpotForecasts(String spotId) async {
    final apiService = ApiService();
    try {
      var responseRating = await apiService.getSpotRating(spotId);
      var responseWind = await apiService.getSpotWind(spotId);

      List<Forecast> forecasts =
          groupEntitiesByTimestamp(responseRating, responseWind);

      setState(() {
        forecastList = forecasts;
      });
    } catch (error) {
      print(error);
    }
  }

/**
 * Scroll to the current time.
 */
  void _scrollToCurrentDate() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _scrollController.animateTo(
        120 * 24, // Adjust the value based on the item height
        duration: Duration(seconds: 1),
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
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    _scrollToCurrentDate();
                  },
                  child: Text('Next'),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  height: 900,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                    ),
                    controller: _scrollController,
                    itemBuilder: (BuildContext context, int index) {
                      final forecast = forecastList[index];
                      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
                          forecast.timestamp * 1000);

                      return Column(
                        children: [
                          SizedBox(
                            height: 40,
                            child: index % 24 == 0
                                ? Text(dateFormatter.format(dateTime),
                                    style:
                                        Theme.of(context).textTheme.titleMedium)
                                : null,
                          ),
                          SizedBox(
                            width: 200,
                            child: TimelineCard(forecast: forecast),
                          )
                        ],
                      );
                    },
                    itemCount: forecastList.length,
                    separatorBuilder: (context, index) => const VerticalDivider(
                      width: 1,
                      thickness: 2,
                      color: Colors.white,
                    ),
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
