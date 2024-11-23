import 'package:flutter/material.dart';
import 'dart:math' as math;

class RotatingRectangle extends StatefulWidget {
  @override
  _RotatingRectangleState createState() => _RotatingRectangleState();
}

class _RotatingRectangleState extends State<RotatingRectangle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        child: Container(
          width: 100.0,
          height: 100.0,
          color: Colors.blue,
        ),
        builder: (context, child) {
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(_controller.value * 2.0 * math.pi),
            child: child,
          );
        },
      ),
    );
  }
}
