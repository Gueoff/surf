import 'package:flutter/material.dart';
import 'package:surf/src/models/spot.dart';
import 'package:surf/src/models/location.dart';
import 'package:surf/src/screens/spotDetails/spot_details_screen.dart';

class FavoriteSpotList extends StatelessWidget {
  late Location location1;
  late Location location2;
  late Spot spot1;
  late Spot spot2;
  late List<Spot> spots;

  FavoriteSpotList({Key? key}) : super(key: key) {
    // Initialize the Location and Spot objects inside the constructor
    location1 = Location(longitude: 40.7128, latitude: -74.0060);
    location2 = Location(longitude: 34.0522, latitude: -118.2437);
    spot1 = Spot("584204204e65fad6a770901d", location1,
        "Saint gilles croix de vie", "spot");
    spot2 = Spot("584204204e65fad6a770901q", location2, "Spot 2", "spot");

    // Initialize the spots list here
    spots = [
      Spot('584204204e65fad6a770901d', location1, 'Saint gilles croix de vie',
          'spot'),
      Spot('584204204e65fad6a770901q', location2, 'Spot 2', 'spot'),
    ];
  }

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
                builder: (context) => SpotDetailsScreen(spot: spot1),
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
