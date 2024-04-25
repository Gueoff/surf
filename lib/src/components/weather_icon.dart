import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WeatherIcon extends StatelessWidget {
  final String condition;

  const WeatherIcon({super.key, required this.condition});

  String getIcon() {
    switch (condition) {
      case 'CLEAR':
        return 'assets/icons/weather/clear-day.svg';
      case 'CLOUDY':
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
      case 'NIGHT_CLEAR':
        return 'assets/icons/weather/clear-night.svg';
      case 'NIGHT_CLOUDY':
      case 'NIGHT_MOSTLY_CLOUDY':
        return 'assets/icons/weather/partly-cloudy-night.svg';
      case 'NIGHT_LIGHT_RAIN':
        return 'assets/icons/weather/partly-cloudy-night-drizzle.svg';
      case 'NIGHT_LIGHT_SHOWERS':
      case 'NIGHT_BRIEF_SHOWERS_POSSIBLE':
        return 'assets/icons/weather/partly-cloudy-night-rain.svg';

      default:
        return 'assets/icons/weather/not-available.svg';
    }
  }

  @override
  Widget build(BuildContext context) {
    print(condition);
    return SvgPicture.asset(getIcon(),
        width: 36, height: 36, semanticsLabel: 'Meteo');
  }
}
