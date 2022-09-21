import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class BotonSnake extends StatelessWidget {
  const BotonSnake({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Boton Snake'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(80.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SnakeButton(
              borderWidth: 2,
              snakeColor: Colors.green.shade100,
              borderColor: Colors.green,
              child: Text('nilton'),
              duration: 20000,
              onTap: () {},
            ),
            SizedBox(
              height: 20,
            ),
            SnakeButton(
              borderWidth: 2,
              snakeColor: Colors.green.shade100,
              borderColor: Colors.green,
              child: Text('nilton'),
              duration: 20000,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

//pinta los bordes y hace que se repita - animacion con duracion
class SnakeButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  final int duration;

  final Color snakeColor;
  final Color borderColor;
  final double borderWidth;

  const SnakeButton(
      {Key? key,
      required this.child,
      this.duration = 500,
      this.snakeColor = Colors.purple,
      this.borderColor = Colors.white,
      this.borderWidth = 4.0,
      required this.onTap})
      : super(key: key);

  @override
  State<SnakeButton> createState() => _SnakeButtonState();
}

class _SnakeButtonState extends State<SnakeButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.duration));

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //CustomPaint va servir para pintar al rededor del boton
    return InkWell(
      onTap: widget.onTap,
      child: CustomPaint(
        painter: _SnakePainter(
            animation: _controller,
            borderColor: widget.borderColor,
            borderWidth: widget.borderWidth,
            snakeColor: widget.snakeColor), //llama a la clase
        child: Container(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: widget.child,
            )),
      ),
    );
  }
}

//crea el retangulo y sus bordes sombreados
class _SnakePainter extends CustomPainter {
  final Animation animation;
  final Color snakeColor;
  final Color borderColor;
  final double borderWidth;

  _SnakePainter(
      {required this.animation,
      this.snakeColor = Colors.purple,
      this.borderColor = Colors.white,
      this.borderWidth = 4.0})
      : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final paint = Paint()
      ..shader = SweepGradient(
        colors: [snakeColor, Colors.transparent],
        stops: const [0.7, 1.0],
        startAngle: 0.0,
        endAngle: vector.radians(360),
        transform: GradientRotation(
          vector.radians(360.0 * animation.value),
        ),
      ).createShader(rect);

    final path = Path.combine(PathOperation.xor, Path()..addRect(rect),
        Path()..addRect(rect.deflate(borderWidth)));

//crear los bordes
    canvas.drawRect(
      rect.deflate(borderWidth * 0.5),
      Paint()
        ..color = borderColor
        ..strokeWidth = borderWidth
        ..style = PaintingStyle.stroke,
    );

//pintar los bordes
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
