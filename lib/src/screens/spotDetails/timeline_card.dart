import 'package:flutter/material.dart';
import 'package:surf/src/components/forecast_rating.dart';
import 'package:surf/src/components/pressable.dart';
import 'package:surf/src/models/forecast.dart';
import 'package:intl/intl.dart';

class TimelineCard extends StatelessWidget {
  final Forecast forecast;
  final Function(Forecast) onCardTap;
  final timeFormatter = DateFormat.Hm();
  late final DateTime dateTime;

  TimelineCard({super.key, required this.forecast, required this.onCardTap}) {
    dateTime = DateTime.fromMillisecondsSinceEpoch(forecast.timestamp * 1000);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 8,
      margin: EdgeInsets.zero,
      shadowColor: const Color.fromRGBO(97, 216, 240, 0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Pressable(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        onTap: () {
          onCardTap(forecast);
        },
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
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
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
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 24),
              child: ForecastRating(ratingValue: forecast.rating.value),
            ),
          ],
        ),
      ),
    );
  }
}
