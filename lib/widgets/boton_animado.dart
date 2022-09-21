import 'package:flutter/material.dart';

class ButtonEnable extends StatefulWidget {
  const ButtonEnable({Key? key}) : super(key: key);

  @override
  State<ButtonEnable> createState() => _ButtonEnableState();
}

class _ButtonEnableState extends State<ButtonEnable> {
  bool enable1 = true;
  bool enable2 = true;
  bool enable3 = true;
  bool enable4 = true;

  bool enablex1 = true;
  bool enablex2 = true;
  bool enablex3 = true;
  bool enablex4 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            BotonAnimado(
                onTap: () {
                  setState(() {
                    if (enablex1) {
                      enable1 = !enable1;
                      enable2 = !enable1;
                      enable3 = !enable1;
                      enable4 = !enable1;
                    } else {
                      enable1 = enable2 = enable4 = enable3 = true;
                    }
                    enablex1 = !enablex1;
                    enablex3 = true;
                    enablex4 = true;
                    enablex2 = true;
                  });
                },
                enableButton: enable1),
            BotonAnimado(
              enableButton: enable2,
              onTap: () {
                setState(() {
                  if (enablex2) {
                    enable2 = !enable2;
                    enable1 = !enable2;
                    enable3 = !enable2;
                    enable4 = !enable2;
                  } else {
                    enable1 = enable2 = enable4 = enable3 = true;
                  }
                  enablex2 = !enablex2;
                  enablex3 = true;
                  enablex4 = true;
                  enablex1 = true;
                });
              },
            ),
            BotonAnimado(
              enableButton: enable3,
              onTap: () {
                setState(() {
                  if (enablex3) {
                    enable3 = !enable3;
                    enable2 = !enable3;
                    enable1 = !enable3;
                    enable4 = !enable3;
                  } else {
                    enable1 = enable2 = enable4 = enable3 = true;
                  }
                  enablex3 = !enablex3;
                  enablex2 = true;
                  enablex4 = true;
                  enablex1 = true;
                });
              },
            ),
            BotonAnimado(
              enableButton: enable4,
              onTap: () {
                setState(() {
                  if (enablex4) {
                    enable4 = !enable4;
                    enable2 = !enable4;
                    enable1 = !enable4;
                    enable3 = !enable4;
                  } else {
                    enable1 = enable2 = enable4 = enable3 = true;
                  }
                  enablex4 = !enablex4;
                  enablex2 = true;
                  enablex3 = true;
                  enablex1 = true;
                });
              },
            ),
          ],
        ));
  }
}

class BotonAnimado extends StatelessWidget {
  final VoidCallback onTap;
  final bool enableButton;

  const BotonAnimado(
      {Key? key, required this.onTap, required this.enableButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: 100,
          height: 100,
          child: AnimatedContainer(
            curve: Curves.decelerate,
            duration: const Duration(seconds: 1),
            color: enableButton ? Colors.green : Colors.black,
          ),
        ),
      ),
    );
  }
}
