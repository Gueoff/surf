import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:surf/src/models/spot.dart';
import 'package:surf/src/redux/app_state.dart';
import 'package:surf/src/redux/spot/spot_actions.dart';
import 'package:surf/src/redux/spot/spot_view_model.dart';

class FavoriteButton extends StatefulWidget {
  final Spot spot;

  const FavoriteButton({
    super.key,
    required this.spot,
  });

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      duration: const Duration(milliseconds: 200), vsync: this, value: 1.0);

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void onAddToFavorites() {
    StoreProvider.of<AppState>(context).dispatch(AddSpotAction(widget.spot));
    _controller.reverse().then((value) => _controller.forward());
  }

  void onRemoveToFavorites() {
    StoreProvider.of<AppState>(context).dispatch(RemoveSpotAction(widget.spot));
    _controller.reverse().then((value) => _controller.forward());
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SpotViewModel>(
      converter: (store) => SpotViewModel.fromStore(store),
      builder: (context, viewModel) {
        bool isFavorite = viewModel.spots
            .any((spotFavorite) => spotFavorite.id == widget.spot.id);

        return GestureDetector(
          onTap: isFavorite ? onRemoveToFavorites : onAddToFavorites,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: BackdropFilter(
                  filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 255, 255, 0.2),
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
              ScaleTransition(
                scale: Tween(begin: 0.8, end: 1.0).animate(CurvedAnimation(
                    parent: _controller, curve: Curves.easeOut)),
                child: Icon(
                  isFavorite
                      ? Icons.bookmark_outlined
                      : Icons.bookmark_outline_outlined,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
