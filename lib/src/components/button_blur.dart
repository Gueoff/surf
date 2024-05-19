import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class ButtonBlur extends StatelessWidget {
  final void Function() onTap;
  final IconData icon;

  const ButtonBlur({
    super.key,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
          Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
        ],
      ),
    );
  }
}
