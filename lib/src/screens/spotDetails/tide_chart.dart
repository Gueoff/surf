import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:surf/src/models/tide.dart';
import 'dart:ui' as ui;
import 'package:surf/src/screens/spotDetails/spot_details_screen.dart';

class TideChart extends StatefulWidget {
  final ScrollController animation;
  final List<Tide> tides;

  const TideChart({super.key, required this.animation, required this.tides});

  @override
  State<TideChart> createState() => _TideChartState();
}

class _TideChartState extends State<TideChart> {
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

  @override
  void paint(Canvas canvas, Size size) {
    int length = tides.length;
    DateTime firstTideDateTime =
        DateTime.fromMillisecondsSinceEpoch(tides[0].timestamp * 1000);
    DateTime startingDate = DateTime(firstTideDateTime.year,
        firstTideDateTime.month, firstTideDateTime.day, 0, 0, 0);
    List<Offset> paragraphPositions = [];
    int wordingWidth = 20;

    Paint gradientPaint = Paint()
      ..strokeWidth = 2
      ..color = color
      ..style = PaintingStyle.stroke;

    Path path = Path()..moveTo(0, size.height / 2);

    for (int i = 0; i < length; i++) {
      Tide currentTide = tides[i];
      DateTime datetime =
          DateTime.fromMillisecondsSinceEpoch(currentTide.timestamp * 1000);
      String time = timeFormatter.format(datetime);
      int dateOffset = datetime.difference(startingDate).inMinutes;

      final ui.ParagraphStyle paragraphStyle = ui.ParagraphStyle(
        fontSize: 12,
      );
      final ui.TextStyle textStyle = ui.TextStyle(color: color);
      final ui.ParagraphBuilder paragraphBuilder =
          ui.ParagraphBuilder(paragraphStyle)..pushStyle(textStyle);
      paragraphBuilder.addText(time);
      ui.Paragraph paragraph = paragraphBuilder.build();
      paragraph.layout(ui.ParagraphConstraints(width: size.width));

      double cardWidth = timelineCardWidth + separatorWidth;
      double screenOffset = screenWidth / 2;

      double x =
          screenOffset + (dateOffset * cardWidth / 180) - offset - wordingWidth;
      double y = currentTide.type == 'LOW' ? size.height - 20 : 20;
      // Draw paragraph times.
      canvas.drawParagraph(
        paragraph,
        Offset(x, y),
      );

      // Stocker la position du paragraphe
      paragraphPositions.add(
        Offset(x + 10, currentTide.type == 'LOW' ? size.height : 0),
      );
    }

    // Relier les points de paragraphe avec des courbes de Bézier cubiques
    for (int i = 0; i < paragraphPositions.length - 1; i++) {
      // Calculer les points de contrôle pour la courbe de Bézier cubique
      Offset start = paragraphPositions[i];
      Offset end = paragraphPositions[i + 1];
      double dx = (end.dx - start.dx) / 2;
      Offset ctrl1 = Offset(start.dx + dx, start.dy);
      Offset ctrl2 = Offset(end.dx - dx, end.dy);

      // Dessiner la courbe de Bézier cubique
      path.cubicTo(ctrl1.dx, ctrl1.dy, ctrl2.dx, ctrl2.dy, end.dx, end.dy);
    }

    canvas.drawPath(path, gradientPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
