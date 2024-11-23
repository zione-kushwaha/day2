import 'dart:math';

import 'package:flutter/material.dart';

class DrawerAnimation extends StatefulWidget {
  const DrawerAnimation({super.key, required this.drawer, required this.child});
  final Widget drawer;
  final Widget child;

  @override
  State<DrawerAnimation> createState() => _DrawerAnimationState();
}

class _DrawerAnimationState extends State<DrawerAnimation>
    with TickerProviderStateMixin {
  late AnimationController _xControllerForChild;
  late AnimationController _xControllerForDrawer;

  late Animation<double> _xOffsetForChild;
  late Animation<double> _xOffsetForDrawer;

  @override
  void initState() {
    super.initState();
    _xControllerForChild = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    _xControllerForDrawer = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    _xOffsetForChild =
        Tween<double>(begin: 0, end: -pi / 2).animate(_xControllerForChild);

    _xOffsetForDrawer =
        Tween<double>(begin: pi / 2.7, end: 0).animate(_xControllerForDrawer);
  }

  @override
  void dispose() {
    _xControllerForChild.dispose();
    _xControllerForDrawer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final drag = size.width * 0.8;

    return GestureDetector(
      onHorizontalDragUpdate: (detail) {
        final delta = detail.delta.dx / drag;
        _xControllerForChild.value += delta;
        _xControllerForDrawer.value += delta;
      },
      onHorizontalDragEnd: (details) {
        if (_xControllerForChild.value >= 0.5) {
          _xControllerForChild.forward();
          _xControllerForDrawer.forward();
        } else {
          _xControllerForChild.reverse();
          _xControllerForDrawer.reverse();
        }
      },
      child: AnimatedBuilder(
          animation: Listenable.merge([
            _xControllerForChild,
            _xControllerForDrawer,
          ]),
          builder: (context, child) {
            return Stack(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    if (_xControllerForChild.value > 0) {
                      _xControllerForChild.reverse();
                      _xControllerForDrawer.reverse();
                    }
                  },
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
                Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..translate(_xControllerForChild.value * drag)
                    ..rotateY(_xOffsetForChild.value),
                  alignment: Alignment.centerLeft,
                  child: widget.child,
                ),
                Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..translate(_xControllerForDrawer.value * drag - size.width)
                    ..rotateY(_xOffsetForDrawer.value),
                  alignment: Alignment.centerRight,
                  child: widget.drawer,
                ),
              ],
            );
          }),
    );
  }
}
