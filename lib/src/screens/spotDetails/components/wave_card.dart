import 'package:flutter/material.dart';
import 'package:surf/src/models/surf.dart';
import 'package:surf/src/models/swell.dart';

double _calculateDifference([double? previousDirection, double? newDirection]) {
  double prev = previousDirection ?? 0.0;
  double newDir = newDirection ?? 0.0;
  return (newDir - prev) / 360;
}

class WaveCard extends StatefulWidget {
  final Surf surf;
  final Swell swell;
  late final SwellElement? swellMain;
  late final SwellElement? swellSecondary;

  WaveCard({super.key, required this.surf, required this.swell}) {
    try {
      swellMain = swell.swells.firstWhere((element) => element.direction != 0);
    } catch (e) {
      swellMain = null;
    }

    try {
      swellSecondary = swell.swells.firstWhere(
          (element) => element != swellMain && element.direction != 0);
    } catch (e) {
      swellSecondary = null;
    }
  }

  @override
  State<WaveCard> createState() => _WaveCardState();
}

class _WaveCardState extends State<WaveCard> {
  late double turnsMain;
  late double turnsSecondary;

  @override
  void initState() {
    super.initState();
    turnsMain = _calculateDifference(0, widget.swellMain?.direction);
    turnsSecondary = _calculateDifference(0, widget.swellSecondary?.direction);
  }

  @override
  void didUpdateWidget(WaveCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.swellMain?.direction != oldWidget.swellMain?.direction) {
      turnsMain += _calculateDifference(
          oldWidget.swellMain?.direction, widget.swellMain?.direction);
    }

    if (widget.swellSecondary?.direction !=
        oldWidget.swellSecondary?.direction) {
      turnsSecondary += _calculateDifference(
          oldWidget.swellSecondary?.direction,
          widget.swellSecondary?.direction);
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
                      Icons.waves,
                      color: Theme.of(context).colorScheme.tertiary,
                      size: 24,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          '${widget.surf.min.toString()} - ${widget.surf.max.toString()}m',
                          style: Theme.of(context).textTheme.bodyLarge),
                      Text(widget.surf.humanRelation,
                          style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  (widget.swellMain != null)
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('${widget.swellMain!.period.toString()}s',
                                style: Theme.of(context).textTheme.labelLarge),
                            AnimatedRotation(
                              duration: const Duration(milliseconds: 600),
                              turns: turnsMain,
                              child: Icon(
                                Icons.arrow_downward,
                                color: Theme.of(context).colorScheme.tertiary,
                                size: 36,
                              ),
                            ),
                          ],
                        )
                      : Container(height: 28),
                  (widget.swellSecondary != null)
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('${widget.swellSecondary!.period.toString()}s',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary)),
                            AnimatedRotation(
                              duration: const Duration(milliseconds: 600),
                              turns: turnsSecondary,
                              child: Icon(
                                Icons.arrow_downward,
                                color: Theme.of(context).colorScheme.onPrimary,
                                size: 28,
                              ),
                            ),
                          ],
                        )
                      : Container(height: 28),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
