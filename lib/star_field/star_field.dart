import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'star_field_painter.dart';

class StarField extends StatefulWidget {
  final double starSpeed;
  final int starCount;

  const StarField({Key? key, this.starSpeed = 3, this.starCount = 500})
      : super(key: key);

  @override
  _StarFieldState createState() => _StarFieldState();
}

class _StarFieldState extends State<StarField> {
  final List<Star> _stars = [];
  final double _maxZ = 500;
  final double _minZ = 1;
  ui.Image? glowImage;

  late Ticker _ticker;

  @override
  void initState() {
    _initStars(context);
    super.initState();
  }

  void _initStars(BuildContext context) {
    _loadGlowImage();
    for (var i = widget.starCount; i-- > 0;) {
      var s = _randomizeStar(Star(), true);
      _stars.add(s);
    }
    _ticker = Ticker(_handleStarTick)..start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,
        child: Builder(builder: (context) {
          if (glowImage != null) {
            return CustomPaint(
              painter: StarFieldPainter(
                _stars,
                glowImage: glowImage!,
              ),
            );
          }
          return const Center();
        }));
  }

  void _handleStarTick(Duration elapsed) {
    setState(() {
      advanceStars(widget.starSpeed);
    });
  }

  void advanceStars(double distance) {
    for (var s in _stars) {
      s.z -= distance; // * elapsed.inMilliseconds;
      if (s.z < _minZ) {
        _randomizeStar(s, false);
      } else if (s.z > _maxZ) {
        s.z = _minZ;
      }
    }
  }

  Star _randomizeStar(Star star, bool randomZ) {
    Random rand = Random();
    star.x = (-1 + rand.nextDouble() * 2) * 75;
    star.y = (-1 + rand.nextDouble() * 2) * 75;
    star.z = randomZ ? rand.nextDouble() * _maxZ : _maxZ;
    star.rotation = rand.nextDouble() * pi * 2;
    if (rand.nextDouble() < .1) {
      star.color = const Color(0xffD4A1FF);
      star.size = 2 + rand.nextDouble() * 2;
    } else {
      star.color = Colors.white;
      star.size = .5 + rand.nextDouble() * 2;
    }
    return star;
  }

  void _loadGlowImage() async {
    final ByteData data = await rootBundle.load('assets/glow.png');
    ui.decodeImageFromList(
        data.buffer.asUint8List(), (image) => glowImage = image);
  }
}
