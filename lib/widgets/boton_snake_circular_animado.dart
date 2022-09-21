import 'dart:math';

import 'package:flutter/material.dart';

class GraficasCircularesPage extends StatefulWidget {
  const GraficasCircularesPage({Key? key}) : super(key: key);

  @override
  State<GraficasCircularesPage> createState() => _GraficasCircularesPageState();
}

class _GraficasCircularesPageState extends State<GraficasCircularesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(100.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SnakeCircular(
                colorArco: Colors.green,
                colorCirculo: Colors.grey,
                grosorArco: 10,
                grosorCirculo: 5,
                duracionSeg: 4,
                onTap: () {
                  print('object');
                },
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SnakeCircular extends StatefulWidget {
  final Color? colorArco;
  final Color? colorCirculo;
  final double? grosorCirculo;
  final double? grosorArco;
  final double lenghtArco;
  final int duracionSeg;
  final Widget child;
  final VoidCallback onTap;

  const SnakeCircular(
      {Key? key,
      this.colorArco = Colors.green,
      this.colorCirculo = const Color.fromARGB(255, 171, 231, 173),
      this.grosorCirculo = 4,
      this.grosorArco = 10,
      this.lenghtArco = 15,
      this.duracionSeg = 4,
      required this.child,
      required this.onTap})
      : super(key: key);

  @override
  State<SnakeCircular> createState() => _SnakeCircularState();
}

class _SnakeCircularState extends State<SnakeCircular>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late double porcentajeAnterior;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: Duration(seconds: widget.duracionSeg));
    controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: CustomPaint(
        painter: _MiSnakeCircular(
            lenghtArco: widget.lenghtArco,
            animation: controller,
            colorArco: widget.colorArco!,
            colorCirculo: widget.colorCirculo!,
            grosorCirculo: widget.grosorCirculo!,
            grosorArco: widget.grosorArco!),
        child: Container(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(100.0),
              child: widget.child,
            )),
      ),
    );
  }
}

//DIBUJO DEL CIRCULO Y EL ARCO
class _MiSnakeCircular extends CustomPainter {
  final Animation animation;
  final double lenghtArco;
  final Color colorArco;
  final Color colorCirculo;
  final double grosorCirculo;
  final double grosorArco;

  _MiSnakeCircular(
      {required this.animation,
      this.lenghtArco = 15,
      this.colorArco = Colors.green,
      this.colorCirculo = const Color.fromARGB(255, 171, 231, 173),
      this.grosorCirculo = 15,
      this.grosorArco = 10})
      : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromCircle(center: Offset.zero, radius: 360);

    final Gradient gradiente = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [colorArco, colorArco.withOpacity(0.2), colorArco],
        stops: const [0.3, 0.8, 1.0]);

    //Arco Detalles
    final paintArco = Paint()
      ..strokeWidth = grosorArco
      ..color = colorArco
      ..shader = gradiente.createShader(rect)
      // ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    //Circulo
    final paintCirculo = Paint()
      ..strokeWidth = grosorCirculo
      ..color = colorCirculo
      ..style = PaintingStyle.stroke;

    final c = Offset(size.width * 0.5, size.height * 0.5); //ubicacion
    final radius = min(size.width * 0.5, size.height * 0.5); //radio del circulo

    canvas.drawCircle(c, radius, paintCirculo);

//CAMBIA EL TAMAñO del arco | 2 * pi * (porcentaje * 0.01);
    double arcAngle = 2 * pi * (lenghtArco * 0.01);

    canvas.drawArc(
      Rect.fromCircle(
        center: c,
        radius: radius,
      ),
      animation.value * 2 * pi, //dinamico para que se mueva
      arcAngle, //tamaño del arco
      false,
      paintArco,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
