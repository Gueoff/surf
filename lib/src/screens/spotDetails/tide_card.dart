import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:surf/src/models/tide.dart';
import 'dart:ui' as ui;

class TideCard extends StatefulWidget {
  final ScrollController animation;
  final List<Tide> tides;

  const TideCard({super.key, required this.animation, required this.tides});

  @override
  State<TideCard> createState() => _TideCardState();
}

class _TideCardState extends State<TideCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: AnimatedBuilder(
          animation: widget.animation,
          builder: (context, child) {
            return CustomPaint(
              painter: SinePainter(widget.animation.offset, widget.tides,
                  Theme.of(context).colorScheme.tertiary),
              child: Container(),
            );
          }),
    );
  }
}

class SinePainter extends CustomPainter {
  final double offset;
  final List<Tide> tides;
  final Color color;
  final timeFormatter = DateFormat.Hm();
  int screenWidth = 411;

  SinePainter(this.offset, this.tides, this.color);

  double timestampToDouble(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

    // Extraire les heures et les minutes de l'objet DateTime
    int hours = dateTime.hour;
    int minutes = dateTime.minute;
    print('$hours : $minutes');

    // Convertir les heures et les minutes en un nombre double
    double result = hours + (minutes / 60);

    return result;
  }

  @override
  void paint(Canvas canvas, Size size) {
    int length = tides.length;
    Paint gradientPaint = Paint()
      ..strokeWidth = 3
      ..color = color
      ..style = PaintingStyle.stroke;

    Path path = Path()..moveTo(0, size.height / 2);
    int first =
        DateTime.fromMillisecondsSinceEpoch(tides[0].timestamp * 1000).day;

    for (int i = 0; i <= length - 1; i++) {
      Tide currentTide = tides[i];
      DateTime datetime =
          DateTime.fromMillisecondsSinceEpoch(currentTide.timestamp * 1000);
      String time = timeFormatter.format(datetime);
      var d = timestampToDouble(currentTide.timestamp);

      // Define wording for high and low tides.
      final ui.ParagraphStyle paragraphStyle = ui.ParagraphStyle(
        fontSize: 12,
      );
      final ui.TextStyle textStyle = ui.TextStyle(color: color);
      final ui.ParagraphBuilder paragraphBuilder =
          ui.ParagraphBuilder(paragraphStyle)..pushStyle(textStyle);
      paragraphBuilder.addText(time);
      ui.Paragraph paragraph = paragraphBuilder.build();
      paragraph.layout(ui.ParagraphConstraints(width: size.width));
// Offset((screenWidth / 2) + i * size.width / 2 - (offset * 2),
      int w = 68;
      // Draw the tide.
      var d = timestampToDouble(currentTide.timestamp);
      print('her ${d}');

      canvas.drawParagraph(
        paragraph,
        Offset((screenWidth / 2) - offset + (d * i * w / 3),
            currentTide.type == 'LOW' ? size.height - 20 : 20),
      );

      // Draw the curve.
      path.lineTo(
        i * size.width / (length - 1),
        size.height / 2 +
            sin((offset / 50) + i * pi / 15) * (size.height / 2 - 3),
      );
    }
    path.lineTo(size.width, size.height / 2);

    canvas.drawPath(path, gradientPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
