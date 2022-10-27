import 'package:flutter/material.dart';

class TextoAnimandose extends StatelessWidget {
  const TextoAnimandose({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextoAnimado(
      widget: Text('fsdv'),
    );
  }
}

class TextoAnimado extends StatelessWidget {
  const TextoAnimado({Key? key, required this.widget}) : super(key: key);

  final Widget widget;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(children: [
          TweenAnimationBuilder<double>(
            curve: Curves.fastLinearToSlowEaseIn,
            builder: (BuildContext context, Object? value, Widget? child) {
              value as double;
              return Transform(
                transform: Matrix4.identity()..translate(100.0 * value),
                child: child!,
              );
            },
            duration: const Duration(milliseconds: 1500),
            tween: Tween(begin: 0, end: 1),
            child: widget,
          ),
        ]),
      ),
    );
  }
}
