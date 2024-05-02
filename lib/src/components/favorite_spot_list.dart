import 'package:flutter/material.dart';
import 'package:surf/src/models/spot.dart';
import 'package:surf/src/screens/spotDetails/spot_details_screen.dart';

class FavoriteSpotList extends StatelessWidget {
  final List<Spot> spots;

  const FavoriteSpotList({super.key, required this.spots});

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
        itemBuilder: (BuildContext context, int index) {
          final spot = spots[index];

          return GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SpotDetailsScreen(spot: spot),
              ),
            ),
            child: Card(
              elevation: 8,
              margin: EdgeInsets.zero,
              shadowColor: const Color.fromRGBO(97, 216, 240, 0.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                height: 300,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Hero(
                        tag: spot.id,
                        child: ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [
                              Colors.transparent,
                              Color.fromRGBO(97, 216, 240, 0.4),
                            ],
                            begin: Alignment.center,
                            end: Alignment.center,
                          ).createShader(bounds),
                          blendMode: BlendMode.darken,
                          child: Image.asset(
                            height: 300,
                            'assets/images/gilles.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        left: 12,
                        bottom: 24,
                        child: Text(spot.name,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary))),
                  ],
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemCount: spots.length,
      ),
    );
  }
}
