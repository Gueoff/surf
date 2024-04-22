import 'package:flutter/material.dart';
import 'package:surf/src/models/Spot.dart';
import 'package:surf/src/screens/spot_details.dart';

class FavoriteSpotList extends StatelessWidget {
  const FavoriteSpotList({super.key});

  static List<Spot> spots = [
    Spot('st gilles', 'Spot', '1'),
    Spot('st gilles', 'Spot', '2'),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 10,
        ),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SpotDetailsScreen(
                spotId: spots[index].id,
              ),
            ),
          ),
          child: Card(
            elevation: 8,
            shadowColor: Color.fromRGBO(97, 216, 240, 0.2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              height: 300,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/images/gilles.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemCount: spots.length,
      ),
    );
  }
}
