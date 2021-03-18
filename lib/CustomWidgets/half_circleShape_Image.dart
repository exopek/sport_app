import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class HalfImageShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width/2, size.height/2.0);
    final bounds = Rect.fromCircle(center: center, radius: 175.0);
    // Offset startPoint = Offset()

    var path = Path()
    //..moveTo(0.0, center.dy - 200.0)
      ..arcTo(bounds, 1.1*pi, 0.8*pi, false)
      ..close();

    canvas.drawPath(path, paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
    throw UnimplementedError();
  }


}
