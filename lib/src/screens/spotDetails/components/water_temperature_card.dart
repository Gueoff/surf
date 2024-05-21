import 'package:flutter/material.dart';
import 'package:surf/src/models/water_temperature.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WaterTemperatureCard extends StatelessWidget {
  final WaterTemperature waterTemperature;

  const WaterTemperatureCard({super.key, required this.waterTemperature});

  String getWetsuit() {
    if (waterTemperature.min <= 8) {
      return '6/5 mm';
    }
    if (waterTemperature.min <= 12) {
      return '5/4 mm';
    }
    if (waterTemperature.min <= 16) {
      return '4/3 mm';
    }
    if (waterTemperature.min <= 20) {
      return '3/2 mm';
    }
    if (waterTemperature.min <= 24) {
      return '2 mm';
    }

    return 'Inchallah';
  }

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: SvgPicture.asset('assets/icons/weather/raindrop.svg',
                        width: 36,
                        height: 36,
                        semanticsLabel: 'Water temperature'),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${waterTemperature.min.toString()}°C',
                          style: Theme.of(context).textTheme.bodyLarge),
                      Text(
                        getWetsuit(),
                        style: Theme.of(context).textTheme.bodySmall,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
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
