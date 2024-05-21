import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:surf/src/models/sunlight.dart';

class SunlightCard extends StatelessWidget {
  final Sunlight sunlight;
  final timeFormatter = DateFormat.Hm();
  late final DateTime dateTime;

  SunlightCard({super.key, required this.sunlight});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 8,
      margin: EdgeInsets.zero,
      shadowColor: const Color.fromRGBO(97, 216, 240, 0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 80,
        ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: SvgPicture.asset('assets/icons/weather/sunrise.svg',
                        width: 36, height: 36, semanticsLabel: 'Sunrise'),
                  ),
                  Text(
                      timeFormatter.format(DateTime.fromMillisecondsSinceEpoch(
                          sunlight.dawn * 1000)),
                      style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: SvgPicture.asset('assets/icons/weather/sunset.svg',
                        width: 36, height: 36, semanticsLabel: 'Sunrise'),
                  ),
                  Text(
                      timeFormatter.format(DateTime.fromMillisecondsSinceEpoch(
                          sunlight.dusk * 1000)),
                      style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
