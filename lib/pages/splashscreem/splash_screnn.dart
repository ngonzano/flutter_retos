import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double scale = 8.0;

  double getHeight() {
    return 120 * scale;
  }

  double getWidth() {
    return 200 * scale;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        scale = 1.0;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          AnimatedPositioned(
            curve: Curves.bounceOut,
            onEnd: () {
              //ListviewbuilderScreen
              // print('revisar: $scale');
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) {
                    return ListviewbuilderScreen();
                  },
                ),
              );
            },
            height: getHeight(),
            width: getWidth(),
            top: size.height * 0.5 - getHeight() * 0.5,
            left: size.width * 0.5 - getWidth() * 0.5,
            duration: const Duration(milliseconds: 1500),
            child: Image.asset(
              'assets/img/logo_app.png',
              fit: BoxFit.fill,
            ),
          )
        ],
      ),
    );
  }
}
