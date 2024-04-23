import 'package:flutter/material.dart';
import 'package:surf/src/components/forecast_rating.dart';
import 'package:surf/src/models/forecast.dart';
import 'package:intl/intl.dart';

class TimelineCard extends StatelessWidget {
  final Forecast forecast;
  final timeFormatter = DateFormat.Hm();
  late DateTime dateTime;

  TimelineCard({Key? key, required this.forecast})
      : dateTime =
            DateTime.fromMillisecondsSinceEpoch(forecast.timestamp * 1000),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 8,
      shadowColor: const Color.fromRGBO(97, 216, 240, 0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).colorScheme.secondary,
                  width: 1,
                ),
              ),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24), topRight: Radius.circular(24)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 16, right: 24, bottom: 16, left: 24),
              child: Center(
                child: Text(timeFormatter.format(dateTime),
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary,
                        )),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ForecastRating(ratingValue: forecast.rating.value),
          ),
          Text(forecast.wind.directionType.toString(),
              style: Theme.of(context).textTheme.labelMedium),
          Text(forecast.wind.direction.toString(),
              style: Theme.of(context).textTheme.labelMedium),
        ],
      ),
    );
  }
}
