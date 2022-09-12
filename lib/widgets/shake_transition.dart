import 'package:flutter/material.dart';

///use in nike,
///efecto rebote
class ShakeTransition extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final double offset;
  final Axis axis;
  final Curve curve;

  const ShakeTransition({
    Key? key,
    required this.child,
    this.duration = const Duration(microseconds: 1000),
    this.offset = 140.0,
    this.axis = Axis.horizontal,
    this.curve = Curves.elasticOut,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      curve: curve,
      builder: (BuildContext context, Object value, Widget? child) {
        value as double;
        return Transform.translate(
          offset: axis == Axis.horizontal
              ? Offset(value * offset, 0.0)
              : Offset(
                  0.0,
                  value * offset,
                ),
          child: child,
        );
      },
      duration: duration,
      tween: Tween(
        begin: 1.0,
        end: 0.0,
      ),
      child: child,
    );
  }
}
