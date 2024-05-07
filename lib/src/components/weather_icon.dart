import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WeatherIcon extends StatelessWidget {
  final String condition;

  const WeatherIcon({super.key, required this.condition});

  String getIcon() {
    switch (condition) {
      case 'CLEAR':
      case 'MOSTLY_CLEAR':
        return 'assets/icons/weather/clear-day.svg';
      case 'CLOUDY':
      case 'MOSTLY_CLOUDY':
        return 'assets/icons/weather/cloudy.svg';
      case 'LIGHT_SHOWERS':
      case 'BRIEF_SHOWERS_POSSIBLE':
        return 'assets/icons/weather/drizzle.svg';
      case 'LIGHT_SHOWERS_POSSIBLE':
        return 'assets/icons/weather/partly-cloudy-day-rain.svg';
      case 'OVERCAST':
        return 'assets/icons/weather/overcast.svg';
      case 'HEAVY_RAIN':
      case 'LIGHT_RAIN':
      case 'RAIN':
        return 'assets/icons/weather/rain.svg';
      case 'HEAVY_THUNDER_STORMS':
        return 'assets/icons/weather/lightning-bolt.svg';
      case 'THUNDER_SHOWERS':
        return 'assets/icons/weather/thunderstorms-rain.svg';
      case 'NIGHT_OVERCAST':
        return 'assets/icons/weather/overcast-night.svg';
      case 'NIGHT_CLEAR':
        return 'assets/icons/weather/clear-night.svg';
      case 'NIGHT_CLOUDY':
      case 'NIGHT_MOSTLY_CLOUDY':
        return 'assets/icons/weather/partly-cloudy-night.svg';
      case 'NIGHT_LIGHT_RAIN':
        return 'assets/icons/weather/partly-cloudy-night-drizzle.svg';
      case 'NIGHT_LIGHT_SHOWERS':
      case 'NIGHT_LIGHT_SHOWERS_POSSIBLE':
      case 'NIGHT_BRIEF_SHOWERS':
      case 'NIGHT_BRIEF_SHOWERS_POSSIBLE':
        return 'assets/icons/weather/partly-cloudy-night-rain.svg';
      case 'NIGHT_THUNDER_STORMS':
      case 'NIGHT_HEAVY_THUNDER_STORMS':
        return 'assets/icons/weather/thunderstorms-night.svg';

      default:
        return 'assets/icons/weather/not-available.svg';
    }
  }

  @override
  Widget build(BuildContext context) {
    log(condition);
    return SvgPicture.asset(getIcon(),
        width: 36, height: 36, semanticsLabel: 'Meteo');
  }
}
