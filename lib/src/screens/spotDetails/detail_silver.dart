import 'dart:math';

import 'package:flutter/material.dart';
import 'package:surf/src/models/Spot.dart';

class DetailSliverDelegate extends SliverPersistentHeaderDelegate {
  final Spot spot;
  final double expandedHeight;
  final double roundedContainerHeight;

  DetailSliverDelegate({
    required this.spot,
    required this.expandedHeight,
    required this.roundedContainerHeight,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      children: [
        Hero(
          tag: spot.type,
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
              'assets/images/gilles.jpg',
              width: MediaQuery.of(context).size.width,
              height: expandedHeight,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
                left: 24,
                right: 24,
              ),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(208, 217, 222, 0.6),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
        Positioned(
            left: 24,
            bottom: 32 + 40,
            child: Text(spot.name,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .primary
                        .withOpacity(titleOpacity(shrinkOffset))))),
        Positioned(
          top: expandedHeight - roundedContainerHeight - shrinkOffset,
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: roundedContainerHeight,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Container(
              alignment: Alignment.center,
              width: 60,
              height: 1,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => 0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }

  double titleOpacity(double shrinkOffset) {
    return 1.0 - max(0.0, shrinkOffset) / maxExtent;
  }
}
