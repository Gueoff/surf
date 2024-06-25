import 'dart:math';
import 'package:flutter/material.dart';
import 'package:surf/src/components/button_blur.dart';
import 'package:surf/src/components/favorite_button.dart';
import 'package:surf/src/models/spot.dart';

class DetailSliverDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final void Function() onShare;
  final double roundedContainerHeight;
  final Spot spot;

  DetailSliverDelegate({
    required this.expandedHeight,
    required this.onShare,
    required this.roundedContainerHeight,
    required this.spot,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      children: [
        Hero(
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
              width: MediaQuery.of(context).size.width,
              height: expandedHeight,
              fit: BoxFit.cover,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return Image.asset(
                  'assets/images/default.jpg',
                  width: MediaQuery.of(context).size.width,
                  height: expandedHeight,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
        ),
        Positioned(
            left: 24,
            top: MediaQuery.of(context).padding.top + 12,
            child: ButtonBlur(
                icon: Icons.arrow_back_ios_outlined,
                onTap: () => Navigator.of(context).pop())),
        Positioned(
          right: 24,
          top: MediaQuery.of(context).padding.top + 12,
          child: FavoriteButton(spot: spot),
        ),
        Positioned(
            right: 24,
            top: MediaQuery.of(context).padding.top + 12 + 48,
            child: ButtonBlur(icon: Icons.share, onTap: onShare)),
        Positioned(
            left: 24,
            bottom: 32 + 40,
            child: Text(spot.name,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .primary
                        .withOpacity(titleOpacity(shrinkOffset))))),
        Positioned(
          top: expandedHeight - roundedContainerHeight - shrinkOffset + 1,
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
    var offset = max(0.0, shrinkOffset) / (maxExtent - 180);
    return 1 - offset < 0 ? 0 : 1 - offset;
  }
}
