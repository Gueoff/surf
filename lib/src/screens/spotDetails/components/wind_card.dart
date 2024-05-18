import 'package:flutter/material.dart';
import 'package:surf/src/models/wind.dart';

double _calculateDifference(double previousDirection, double newDirection) {
  return (newDirection - previousDirection) / 360;
}

class WindCard extends StatefulWidget {
  final Wind wind;

  const WindCard({super.key, required this.wind});

  @override
  State<WindCard> createState() => _WindCardState();
}

class _WindCardState extends State<WindCard> {
  late double turns;

  @override
  void initState() {
    super.initState();
    turns = _calculateDifference(0, widget.wind.direction);
  }

  @override
  void didUpdateWidget(WindCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.wind.direction != oldWidget.wind.direction) {
      turns +=
          _calculateDifference(oldWidget.wind.direction, widget.wind.direction);
    }
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
                      Text(widget.wind.directionType.toString(),
                          style: Theme.of(context).textTheme.labelMedium),
                      Text('${widget.wind.speed.round().toString()} km/h',
                          style: Theme.of(context).textTheme.labelMedium),
                      Text(
                          'Rafales à ${widget.wind.gust.round().toString()} km/h',
                          style: Theme.of(context).textTheme.labelSmall),
                    ],
                  ),
                ],
              ),
              AnimatedRotation(
                duration: const Duration(milliseconds: 600),
                turns: turns,
                child: Icon(
                  Icons.arrow_downward,
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
