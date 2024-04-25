import 'package:flutter/material.dart';
import 'package:surf/src/models/wind.dart';
import 'dart:math' as math;

class WindCard extends StatelessWidget {
  final Wind wind;

  const WindCard({super.key, required this.wind});

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
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Icon(
                      Icons.air,
                      color: Theme.of(context).colorScheme.tertiary,
                      size: 24,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(wind.directionType.toString(),
                          style: Theme.of(context).textTheme.labelMedium),
                      Text('${wind.speed.round().toString()} km/h',
                          style: Theme.of(context).textTheme.labelMedium),
                      Text('Rafales à ${wind.gust.round().toString()} km/h',
                          style: Theme.of(context).textTheme.labelSmall)
                    ],
                  ),
                ],
              ),
              Transform.rotate(
                angle: (wind.direction - 180) * (math.pi / 180),
                child: Icon(
                  Icons.arrow_upward,
                  color: Theme.of(context).colorScheme.tertiary,
                  size: 36,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
