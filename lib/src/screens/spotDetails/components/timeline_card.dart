import 'package:flutter/material.dart';
import 'package:surf/src/components/forecast_rating.dart';
import 'package:surf/src/components/pressable.dart';
import 'package:surf/src/models/forecast.dart';
import 'package:intl/intl.dart';

class TimelineCard extends StatelessWidget {
  final Forecast forecast;
  final Function(Forecast)? onCardTap;
  final int intervalHours;
  final timeFormatter = DateFormat.Hm();
  late final DateTime dateTime;
  late final bool isPast;

  TimelineCard(
      {super.key,
      required this.forecast,
      this.onCardTap,
      required this.intervalHours}) {
    dateTime = DateTime.fromMillisecondsSinceEpoch(forecast.timestamp * 1000);

    DateTime now = DateTime.now();
    DateTime previousTime = now.subtract(Duration(hours: intervalHours - 1));
    isPast = previousTime.difference(dateTime).inHours > 0;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isPast ? Theme.of(context).colorScheme.surface : Colors.white,
      elevation: 8,
      margin: EdgeInsets.zero,
      shadowColor: const Color.fromRGBO(12, 68, 93, 0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Pressable(
        borderRadius: const BorderRadius.all(Radius.circular(14)),
        onTap: () {
          if (onCardTap != null) {
            onCardTap!(forecast);
          }
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
                    topLeft: Radius.circular(14),
                    topRight: Radius.circular(14)),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 8, right: 4, bottom: 8, left: 4),
                child: Center(
                  child: Text(timeFormatter.format(dateTime),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onSecondary,
                          )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 24),
              child: Center(
                  child: ForecastRating(ratingValue: forecast.rating.value)),
            ),
          ],
        ),
      ),
    );
  }
}
