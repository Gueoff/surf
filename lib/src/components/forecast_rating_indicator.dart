import 'package:flutter/material.dart';

class ForecastRatingIndicator extends StatelessWidget {
  final int ratingValue;

  const ForecastRatingIndicator({super.key, required this.ratingValue});

  Color getColor() {
    switch (ratingValue) {
      case 0:
        return const Color(0xFFf4496d);
      case 1:
        return const Color(0xFFFF9500);
      case 2:
        return const Color(0xFFffcd1e);
      case 3:
        return const Color(0xFF0bd674);
      case 4:
        return const Color(0xFF009371);
      case 5:
        return const Color(0xFF6851f4);
      case 6:
        return const Color(0xFF5c00d0);
      default:
        return const Color(0XFFFFFFFF);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 3,
      width: double.infinity,
      decoration: BoxDecoration(
        color: getColor(),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
