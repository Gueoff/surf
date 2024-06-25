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

          return Card(
            elevation: 8,
            margin: EdgeInsets.zero,
            shadowColor: const Color.fromRGBO(97, 216, 240, 0.2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Hero(
                    tag: spot.uuid,
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
                      child: Image.network(
                        spot.image,
                        height: 300,
                        width: 200,
                        fit: BoxFit.cover,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return Image.asset(
                            'assets/images/default.jpg',
                            fit: BoxFit.cover,
                            height: 300,
                            width: 200,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Positioned(
                    left: 12,
                    bottom: 24,
                    width: 200 - 24,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          spot.name,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                  color: Theme.of(context).colorScheme.primary),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 4),
                              child: Icon(
                                Icons.location_pin,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                            Text(spot.location?.region ?? '',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary)),
                          ],
                        )
                      ],
                    )),
                Positioned.fill(
                    child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SpotDetailsScreen(spot: spot),
                      ),
                    ),
                    splashColor: const Color.fromRGBO(149, 229, 254, 0.4),
                  ),
                )),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemCount: spots.length,
      ),
    );
  }
}
