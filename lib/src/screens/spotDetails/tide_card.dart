import 'package:flutter/material.dart';

class TideCard extends StatelessWidget {
  const TideCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Colors.blue, height: 200),
        ClipPath(
            clipper: BezierClipper(),
            child: Container(color: Colors.white, height: 200)),
      ],
    );
  }
}

class BezierClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    print(size);
    Path path = Path();

    path.lineTo(0, size.height * 0.75);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.5,
        size.width * 0.5, size.height * 0.75);
    path.quadraticBezierTo(
        size.width * 0.75, size.height, size.width, size.height * 0.75);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
