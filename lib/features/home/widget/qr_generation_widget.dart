import 'package:custom_qr_generator_2/custom_qr_generator.dart';
import 'package:flutter/material.dart';

class QrGeneration extends StatelessWidget {
  const QrGeneration({super.key, required this.url});
  final String url;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: const Size(350, 350),
        painter: QrPainter(
          data: url,
          options: const QrOptions(
            shapes: QrShapes(
                darkPixel: QrPixelShapeRoundCorners(cornerFraction: .5),
                frame: QrFrameShapeRoundCorners(cornerFraction: .25),
                ball: QrBallShapeRoundCorners(cornerFraction: .25)),
          ),
        ),
      ),
    );
  }
}
