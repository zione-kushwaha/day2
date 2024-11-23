import "dart:math";
import "package:flutter/material.dart";
import 'package:vector_math/vector_math_64.dart' show Vector3;

class animation2 extends StatefulWidget {
  const animation2({super.key});
  @override
  State<animation2> createState() => _animation2State();
}

class _animation2State extends State<animation2> with TickerProviderStateMixin {
  late AnimationController _xController;
  late AnimationController _yController;
  late AnimationController _zController;
  late Tween<double> _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _xController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );
    _yController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    );
    _zController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 40),
    );
    _animation = Tween<double>(
      begin: 0,
      end: pi * 2,
    );
  }

  @override
  void dispose() {
    // TODO: implement
    _xController.dispose();
    _yController.dispose();
    _zController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _xController
      ..reset()
      ..repeat();

    _yController
      ..reset()
      ..repeat();
    _zController
      ..reset()
      ..repeat();

    final width = 100.0;
    final height = 100.0;
    return Column(
      children: [
        const SizedBox(
          height: 100,
          width: double.infinity,
        ),
        AnimatedBuilder(
            animation:
                Listenable.merge([_xController, _yController, _zController]),
            builder: (context, child) {
              return Transform(
                transform: Matrix4.identity()
                  ..rotateX(_animation.evaluate(_xController))
                  ..rotateY(_animation.evaluate(_yController))
                  ..rotateZ(_animation.evaluate(_zController)),
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    //front
                    Container(
                      height: height,
                      width: width,
                      color: Colors.green,
                    ),
                    //back
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..translate(Vector3(0, 0, -width)),
                      child: Container(
                        height: height,
                        width: width,
                        color: Colors.purple,
                      ),
                    ),
                    //left side
                    Transform(
                      alignment: Alignment.centerLeft,
                      transform: Matrix4.identity()..rotateY(pi / 2),
                      child: Container(
                        height: height,
                        width: width,
                        color: Colors.red,
                      ),
                    ),
                    //right side
                    Transform(
                      alignment: Alignment.centerRight,
                      transform: Matrix4.identity()..rotateY(-pi / 2),
                      child: Container(
                        height: height,
                        width: width,
                        color: Colors.blue,
                      ),
                    ),
                    //top
                    Transform(
                      alignment: Alignment.topCenter,
                      transform: Matrix4.identity()..rotateX(-pi / 2),
                      child: Container(
                        height: height,
                        width: width,
                        color: Colors.yellow,
                      ),
                    ),

                    Transform(
                      alignment: Alignment.bottomCenter,
                      transform: Matrix4.identity()..rotateX(pi / 2),
                      child: Container(
                        height: height,
                        width: width,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              );
            })
      ],
    );
  }
}
