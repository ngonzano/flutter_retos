import 'package:flutter/material.dart';
import 'package:flutter_retos/models/clipper_model.dart';

class ClipperPage extends StatefulWidget {
  const ClipperPage({Key? key}) : super(key: key);

  @override
  State<ClipperPage> createState() => _ClipperPageState();
}

class _ClipperPageState extends State<ClipperPage>
    with SingleTickerProviderStateMixin {
  DbranchSkin _current = skins.first;
  DbranchSkin _past = skins.last;
  late AnimationController _controller;

  void _onSkinSelect(DbranchSkin skin) {
    setState(() {
      _current = skin;
    });
    _controller.forward(from: 0.0).whenComplete(() {
      setState(() {
        _past = _current;
      });
    });
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      upperBound: 2.5,
      duration: const Duration(milliseconds: 400),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DBrad Skin Selection.'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    _past.image!,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned.fill(
                    child: AnimatedBuilder(
                  animation: _controller,
                  builder: (_, __) {
                    return ClipPath(
                      clipper: _SkinClipper(percent: _controller.value),
                      child: Image.asset(
                        _current.image!,
                        fit: BoxFit.contain,
                      ),
                    );
                  },
                )),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  '${_current.name}',
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: Colors.green),
                )
              ],
            ),
          ),
          Expanded(
              child: GridView.builder(
                  padding: const EdgeInsets.all(10.0),
                  itemCount: skins.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemBuilder: (context, index) {
                    return _SkinButton(
                      skin: skins[index],
                      select: _current.color == skins[index].color,
                      onTap: () {
                        _onSkinSelect(skins[index]);
                      },
                    );
                  }))
        ],
      ),
    );
  }
}

class _SkinClipper extends CustomClipper<Path> {
  final double percent;

  _SkinClipper({required this.percent});

  @override
  Path getClip(Size size) {
    final path = Path();
    path.addOval(
      Rect.fromCenter(
        //Offset ahy que variarlo para que cambie de lado.
        center: Offset(
          size.width * 0.5,
          size.height * 0.5,
        ),
        width: size.width * percent,
        height: size.height * percent,
      ),
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class _SkinButton extends StatelessWidget {
  const _SkinButton(
      {Key? key, required this.skin, required this.onTap, this.select = false})
      : super(key: key);

  final DbranchSkin skin;
  final VoidCallback onTap;
  final bool select;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(40),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.green,
            width: select ? 5.0 : 1.0,
          ),
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(skin.color!),
          ),
        ),
      ),
    );
  }
}
