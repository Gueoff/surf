import 'package:flutter/material.dart';

class ForecastRating extends StatelessWidget {
  final int ratingValue;

  const ForecastRating({super.key, required this.ratingValue});

  // Compute value to get more realistic score.
  int getScore() {
    switch (ratingValue) {
      case 0:
        return 0;
      case 1:
        return 2;
      case 2:
        return 3;
      case 3:
        return 4;
      case 4:
        return 5;
      case 5:
        return 6;
      case 6:
        return 6;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    int value = getScore();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          value == 0
              ? Icons.star_border
              : value == 1
                  ? Icons.star_half
                  : Icons.star, // 2
          color: const Color.fromRGBO(252, 220, 18, 1),
          size: 20,
        ),
        Icon(
          value <= 2
              ? Icons.star_border
              : value == 3
                  ? Icons.star_half
                  : Icons.star,
          color: const Color.fromRGBO(252, 220, 18, 1),
          size: 20,
        ),
        Icon(
          value <= 4
              ? Icons.star_border
              : value == 5
                  ? Icons.star_half
                  : Icons.star,
          color: const Color.fromRGBO(252, 220, 18, 1),
          size: 20,
        ),
      ],
    );
  }
}
