import 'package:flutter/material.dart';
import 'package:surf/src/models/surf.dart';
import 'package:surf/src/models/swell.dart';
import 'dart:math' as math;

class WaveCard extends StatelessWidget {
  final Surf surf;
  final Swell swell;
  late final SwellElement swellMain;
  late final SwellElement swellSecondary;

  WaveCard({super.key, required this.surf, required this.swell}) {
    swellMain = swell.swells[0];
    swellSecondary = swell.swells.length > 1 ? swell.swells[1] : swellMain;
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
                      Text(surf.humanRelation,
                          style: Theme.of(context).textTheme.labelMedium),
                      Text('${surf.min.toString()} - ${surf.max.toString()}m',
                          style: Theme.of(context).textTheme.labelMedium),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('${swellMain.period.toString()}s',
                          style: Theme.of(context).textTheme.labelMedium),
                      Transform.rotate(
                        angle: (swellMain.direction - 180) * (math.pi / 180),
                        child: Icon(
                          Icons.arrow_upward,
                          color: Theme.of(context).colorScheme.tertiary,
                          size: 36,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('${swellSecondary.period.toString()}s',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary)),
                      Transform.rotate(
                        angle:
                            (swellSecondary.direction - 180) * (math.pi / 180),
                        child: Icon(
                          Icons.arrow_upward,
                          color: Theme.of(context).colorScheme.onPrimary,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
