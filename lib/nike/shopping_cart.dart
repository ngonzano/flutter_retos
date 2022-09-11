import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/model_shoes_store.dart';
import 'provider/provider.dart';

const double _buttonSizeWidth = 160.0;
const double _buttonSizeHeight = 60.0;
const double _buttonCircularSize = 60;
const double _imageSize = 120;
const double _finalImageSize = 30;

class ShoppingCart extends StatefulWidget {
  final Shoes shoes;
  const ShoppingCart({Key? key, required this.shoes}) : super(key: key);

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animationResize;
  Animation<double>? _animationMovementIn;
  Animation<double>? _animationMovementOut;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    _animationResize = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: const Interval(0.0, 0.2),
      ),
    );

    _animationMovementIn = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: const Interval(0.3, 0.6, curve: Curves.fastLinearToSlowEaseIn),
      ),
    );
    _animationMovementOut = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: const Interval(0.8, 1.0, curve: Curves.elasticIn),
      ),
    );
    _controller!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pop(true);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      color: Colors.transparent,
      child: AnimatedBuilder(
        animation: _controller!,
        builder: (BuildContext context, Widget? child) {
          final double butonSizeWidth_ =
              (_buttonSizeWidth * _animationResize!.value).clamp(
            _buttonCircularSize,
            _buttonSizeWidth,
          );
          final double buttonSizeHeigth_ =
              (_buttonSizeHeight * _animationResize!.value).clamp(
            _buttonCircularSize,
            _buttonSizeHeight,
          );

          final double panelSizeWidth = (size.width * _animationResize!.value)
              .clamp(_buttonCircularSize, size.width);

          final double panelSizeHeight = (size.height * _animationResize!.value)
              .clamp(_buttonCircularSize, size.height);

          EnableButtonShopping watch = context.watch<EnableButtonShopping>();

          return Stack(
            fit: StackFit.expand,
            children: [
              Positioned.fill(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      color: Colors.black87.withOpacity(0.7),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Stack(
                  children: [
                    if (_animationMovementIn!.value != 1) ...[
                      Positioned(
                        top: size.height * 0.4 +
                            (_animationMovementIn!.value *
                                size.height *
                                0.4758),
                        left: size.width * 0.5 - panelSizeWidth * 0.5,
                        width: panelSizeWidth,
                        height: panelSizeHeight,
                        child: AnimacionPanel(
                          size: size,
                          shoes: widget.shoes,
                          animationResize: _animationResize!,
                        ),
                      ),
                    ],
                    //boton del panel
                    ButtonShopping(
                      animationMovementOut: _animationMovementOut,
                      size: size,
                      butonSizeWidth_: butonSizeWidth_,
                      controller: _controller,
                      buttonSizeHeigth_: buttonSizeHeigth_,
                      animationResize: _animationResize,
                      enableColor: watch.enableButtonShopping
                          ? Colors.black
                          : Colors.grey, //TODO: cambiar el color pay
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class ButtonShopping extends StatelessWidget {
  final Color enableColor;
  const ButtonShopping({
    Key? key,
    required Animation<double>? animationMovementOut,
    required this.size,
    required this.butonSizeWidth_,
    required AnimationController? controller,
    required this.buttonSizeHeigth_,
    required Animation<double>? animationResize,
    required this.enableColor,
  })  : _animationMovementOut = animationMovementOut,
        _controller = controller,
        _animationResize = animationResize,
        super(key: key);

  final Animation<double>? _animationMovementOut;
  final Size size;
  final double butonSizeWidth_;
  final AnimationController? _controller;
  final double buttonSizeHeigth_;
  final Animation<double>? _animationResize;

  @override
  Widget build(BuildContext context) {
    EnableButtonShopping watch = context.watch<EnableButtonShopping>();
    return Positioned(
      bottom: 40 - (_animationMovementOut!.value * 100),
      left: size.width * 0.5 - butonSizeWidth_ * 0.5,
      child: TweenAnimationBuilder(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubicEmphasized,
        builder: (BuildContext context, Object? value, Widget? child) {
          value as double;
          return Transform.translate(
            offset: Offset(
              0.0,
              value * size.height * 0.6,
            ),
            child: child,
          );
        },
        tween: Tween(begin: 1.0, end: 0.0),
        child: InkWell(
          onTap: watch.enableButtonShopping
              ? () {
                  _controller!.forward(); //inicia la animacion
                }
              : () {},
          child: Container(
            width: butonSizeWidth_,
            height: buttonSizeHeigth_,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: enableColor, //aqui cambiar de color
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  const Expanded(
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                    ),
                  ),
                  //para que solo sea visible cuando la animacion no ha empezado
                  if (_animationResize!.value == 1) ...[
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Agregar al carrito',
                      style: TextStyle(color: Colors.white),
                    ),
                  ]
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AnimacionPanel extends StatefulWidget {
  const AnimacionPanel({
    Key? key,
    required this.size,
    required this.shoes,
    required this.animationResize,
  }) : super(key: key);

  final Size size;
  final Shoes shoes;
  final Animation<double> animationResize;

  @override
  State<AnimacionPanel> createState() => _AnimacionPanelState();
}

class _AnimacionPanelState extends State<AnimacionPanel> {
  bool enable1 = true;
  bool enable2 = true;
  bool enable3 = true;
  bool enable4 = true;
  bool enable5 = true;

  bool enablex1 = true;
  bool enablex2 = true;
  bool enablex3 = true;
  bool enablex4 = true;
  bool enablex5 = true;

  @override
  Widget build(BuildContext context) {
    final currentImageSize = (_imageSize * widget.animationResize.value)
        .clamp(_finalImageSize, _imageSize);
    EnableButtonShopping watch = context.watch<EnableButtonShopping>();
    return TweenAnimationBuilder(
      curve: Curves.easeInOutCubicEmphasized,
      builder: (BuildContext context, Object? value, Widget? child) {
        value as double;
        return Transform.translate(
          offset: Offset(
            0.0,
            value * widget.size.height * 0.6,
          ),
          child: child,
        );
      },
      duration: const Duration(milliseconds: 1000),
      tween: Tween(begin: 1.0, end: 0.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(30),
            topRight: const Radius.circular(30),
            bottomLeft: widget.animationResize.value == 1
                ? const Radius.circular(0)
                : const Radius.circular(30),
            bottomRight: widget.animationResize.value == 1
                ? const Radius.circular(0)
                : const Radius.circular(30),
          ),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: widget.animationResize.value == 1
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: widget.animationResize.value == 1
                  ? const EdgeInsets.symmetric(horizontal: 20)
                  : const EdgeInsets.symmetric(horizontal: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    widget.shoes.images!.first,
                    height: currentImageSize + 20,
                  ),
                  if (widget.animationResize.value == 1) ...[
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            textAlign: TextAlign.end,
                            widget.shoes.model!,
                            maxLines: 2,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'S/. ${widget.shoes.currentPrice}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    )
                  ]
                ],
              ),
            ),
            if (widget.animationResize.value == 1) ...[
              const SizedBox(
                height: 20,
              ),
              const Divider(
                color: Colors.grey,
                height: 20,
                indent: 30,
                endIndent: 30,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.fingerprint),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Seleccionar una talla.'.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ButtonTalla(
                          talla: 6,
                          enableButton: enable1,
                          onTapButton: () {
                            context
                                .read<EnableButtonShopping>()
                                .setBoolButton(enableShopping: enablex1);
                            setState(() {
                              if (enablex1) {
                                enable1 = !enable1;
                                enable2 = !enable1;
                                enable3 = !enable1;
                                enable4 = !enable1;
                                enable5 = !enable1;
                              } else {
                                enable1 = enable2 =
                                    enable4 = enable3 = enable5 = true;
                              }
                              enablex1 = !enablex1;
                              enablex3 = true;
                              enablex4 = true;
                              enablex2 = true;
                              enablex5 = true;
                            });
                          },
                        ),
                        ButtonTalla(
                          talla: 7,
                          enableButton: enable2,
                          onTapButton: () {
                            context
                                .read<EnableButtonShopping>()
                                .setBoolButton(enableShopping: enablex2);
                            setState(() {
                              if (enablex2) {
                                enable2 = !enable2;
                                enable1 = !enable2;
                                enable3 = !enable2;
                                enable4 = !enable2;
                                enable5 = !enable2;
                              } else {
                                enable1 = enable2 =
                                    enable4 = enable3 = enable5 = true;
                              }
                              enablex2 = !enablex2;
                              enablex3 = true;
                              enablex4 = true;
                              enablex1 = true;
                              enablex5 = true;
                            });
                          },
                        ),
                        ButtonTalla(
                          talla: 9,
                          enableButton: enable3,
                          onTapButton: () {
                            context
                                .read<EnableButtonShopping>()
                                .setBoolButton(enableShopping: enablex3);
                            setState(() {
                              if (enablex3) {
                                enable3 = !enable3;
                                enable2 = !enable3;
                                enable1 = !enable3;
                                enable4 = !enable3;
                                enable5 = !enable3;
                              } else {
                                enable1 = enable2 =
                                    enable4 = enable3 = enable5 = true;
                              }
                              enablex3 = !enablex3;
                              enablex2 = true;
                              enablex4 = true;
                              enablex1 = true;
                              enablex5 = true;
                            });
                          },
                        ),
                        ButtonTalla(
                          talla: 9.5,
                          enableButton: enable4,
                          onTapButton: () {
                            context
                                .read<EnableButtonShopping>()
                                .setBoolButton(enableShopping: enablex4);
                            setState(() {
                              if (enablex4) {
                                enable4 = !enable4;
                                enable2 = !enable4;
                                enable1 = !enable4;
                                enable3 = !enable4;
                                enable5 = !enable4;
                              } else {
                                enable1 = enable2 =
                                    enable4 = enable3 = enable5 = true;
                              }
                              enablex4 = !enablex4;
                              enablex2 = true;
                              enablex3 = true;
                              enablex1 = true;
                              enablex5 = true;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ButtonTalla(
                  talla: 10,
                  enableButton: enable5,
                  onTapButton: () {
                    context
                        .read<EnableButtonShopping>()
                        .setBoolButton(enableShopping: enablex5);
                    setState(() {
                      if (enablex5) {
                        enable5 = !enable5;
                        enable2 = !enable5;
                        enable1 = !enable5;
                        enable3 = !enable5;
                        enable4 = !enable5;
                      } else {
                        enable1 = enable2 = enable4 = enable3 = enable5 = true;
                      }
                      enablex5 = !enablex5;
                      enablex2 = true;
                      enablex3 = true;
                      enablex1 = true;
                      enablex4 = true;
                    });
                  },
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}

class ButtonTalla extends StatelessWidget {
  final double talla;
  final VoidCallback onTapButton;
  final bool enableButton;

  const ButtonTalla({
    Key? key,
    required this.talla,
    required this.enableButton,
    required this.onTapButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: InkWell(
          onTap: onTapButton,
          child: SizedBox(
            width: 65,
            height: 40,
            child: AnimatedContainer(
              curve: Curves.decelerate,
              duration: const Duration(milliseconds: 500),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade400, //borde
                  width: 0.3,
                ),
                color: enableButton ? Colors.white : Colors.black, //cambiar
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  'US $talla',
                  style: TextStyle(
                    color: enableButton ? Colors.black : Colors.white, //cambiar
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
