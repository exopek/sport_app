import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class ShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width/10, size.height/2);
    final bounds = Rect.fromCircle(center: center, radius: 200.0);
   // Offset startPoint = Offset()

    var path = Path()
      //..moveTo(0.0, center.dy - 200.0)
      ..arcTo(bounds, 3*pi/2.2, 1.3*pi, false)
      ..close();

    canvas.drawPath(path, paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
    throw UnimplementedError();
  }


}


