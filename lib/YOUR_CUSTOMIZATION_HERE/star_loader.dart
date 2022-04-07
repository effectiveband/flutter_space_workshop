import 'package:flutter/material.dart';
import 'dart:math';

double numberOfSparklingStars = 0.9;

class StarField extends StatefulWidget {
  const StarField({Key? key}) : super(key: key);

  @override
  _StarFieldState createState() => _StarFieldState();
}

class _StarFieldState extends State<StarField>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  List<SparkleStar> sparkleStars = [];

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 10000),
      vsync: this,
    )..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onPanStart: onPanStart,
        onPanUpdate: onPanUpdate,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, __) {
            processStars();
            return CustomPaint(
              painter: MyPainter(sparkleStars),
            );
          },
        ));
  }

  void processStars() {
    for (int i = 0; i < sparkleStars.length; i++) {
      if (!sparkleStars[i].sparkle()) {
        sparkleStars.removeAt(i);
        i -= 1;
      }
    }

    if (Random().nextDouble() < numberOfSparklingStars) {
      sparkleStars.add(SparkleStar());
    }
  }

  void onPanStart(DragStartDetails details) {
    setState(() {
      sparkleStars.add(SparkleStar.fromCoords(
          details.localPosition.dx, details.localPosition.dy));
    });
  }

  void onPanUpdate(DragUpdateDetails details) {
    setState(() {
      sparkleStars.add(SparkleStar.fromCoords(
          details.localPosition.dx, details.localPosition.dy));
    });
  }
}

class MyPainter extends CustomPainter {
  final List<SparkleStar> sparkleStars;

  MyPainter(this.sparkleStars);

  @override
  void paint(Canvas canvas, Size size) {
    for (var star in sparkleStars) {
      canvas.drawCircle(Offset(star.x, star.y), star.radius,
          Paint()..color = Color.fromRGBO(255, 255, 220, star.alpha));
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class SparkleStar {
  double x = Random().nextDouble() * 600;
  double y = Random().nextDouble() * 200;
  double radius = Random().nextDouble() * 1 + 0.5;
  double alpha = 0;
  double step = 0.02;
  bool increasing = true;

  SparkleStar();

  SparkleStar.fromCoords(_x, _y) {
    x = _x;
    y = _y;
  }

  sparkle() {
    if (increasing) {
      if (alpha < 1) {
        alpha += step;
      } else {
        increasing = false;
      }
    } else {
      if (alpha > 0) {
        alpha -= step;
      } else {
        return false;
      }
    }

    return true;
  }
}
