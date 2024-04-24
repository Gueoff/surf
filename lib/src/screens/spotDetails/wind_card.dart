import 'package:flutter/material.dart';
import 'package:surf/src/models/wind.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

class WindCard extends StatelessWidget {
  final Wind wind;
  final timeFormatter = DateFormat.Hm();
  late DateTime dateTime;

  WindCard({Key? key, required this.wind});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 8,
      shadowColor: const Color.fromRGBO(97, 216, 240, 0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 16, right: 24, bottom: 16, left: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(wind.directionType.toString(),
                      style: Theme.of(context).textTheme.labelMedium),
                  Text(wind.direction.toString(),
                      style: Theme.of(context).textTheme.labelMedium),
                ],
              ),
              Transform.rotate(
                angle: (wind.direction - 180) * (math.pi / 180),
                child: Icon(
                  Icons.arrow_upward,
                  color: Theme.of(context).colorScheme.tertiary,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
