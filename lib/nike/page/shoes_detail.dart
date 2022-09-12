import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_retos/nike/page/pages.dart';
import '../../widgets/widgets.dart';
import '../model/model_shoes_store.dart';
import '../provider/provider.dart';

class ShoesDetails extends StatelessWidget {
  //para no usar un setState y sea animado el menu con un cambio de estado
  final ValueNotifier<bool> notifierButtonsVisible = ValueNotifier(false);

  ShoesDetails({Key? key, required this.shoes}) : super(key: key);

  final Shoes shoes;

  @override
  Widget build(BuildContext context) {
    //cuando el widget ya fue mostrado que recien aparezca
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ///true lo hace aparecer, false desaparece
      notifierButtonsVisible.value = true;
    });
    final size = MediaQuery.of(context).size;
    EnableButtonShopping watch = context.watch<EnableButtonShopping>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 4),
            child: Image.network(
              'https://graffica.info/wp-content/uploads/2022/04/logotipo-nike-838x285x80xX.jpeg',
              height: 20,
            ),
          ),
        ),
        body: Stack(
          children: [
            //TODO: Referente al contenido del page
            Column(
              children: [
                //TODO: Referente al Carrucel
                _buildCarousel(size, context),
                //TODO: Referente a contenido textual y sus animaciones
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ShakeTransition(
                        duration: const Duration(milliseconds: 1200),
                        child: Text(
                          shoes.model!,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Spacer(),
                          ShakeTransition(
                            duration: const Duration(milliseconds: 1200),
                            offset: -140,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'S/.${shoes.oldPrice!}',
                                  style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                      decoration: TextDecoration.lineThrough),
                                ),
                                Text(
                                  'S/.${shoes.currentPrice!}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const ShakeTransition(
                        duration: Duration(milliseconds: 1200),
                        child: Text(
                          'TALLAS DISPONIBLES',
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ShakeTransition(
                        duration: const Duration(milliseconds: 1300),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            _ShoesSizeItem(text: '6'),
                            _ShoesSizeItem(text: '7'),
                            _ShoesSizeItem(text: '8'),
                            _ShoesSizeItem(text: '9'),
                            _ShoesSizeItem(text: '10'),
                            Text(' ')
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      ShakeTransition(
                        duration: const Duration(milliseconds: 1400),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: const [
                            Text(
                              'DESCRIPCION',
                              style: TextStyle(fontSize: 11),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Rinde al máximo en el juego con las Nike Mercurial Superfly 8 Elite FG que destaca porque su antepié es zona clave que te ayudará a driblar, hacer pases y tiros con mucha precisión.',
                              style: TextStyle(fontSize: 11),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            //TODO: Referente a los FloatingActionButton y su animacion
            ValueListenableBuilder(
                valueListenable: notifierButtonsVisible,
                builder: (BuildContext context, value, Widget? child) {
                  value as bool;
                  return AnimatedPositioned(
                    duration: const Duration(milliseconds: 500),
                    left: 20,
                    right: 20,
                    bottom: value ? 20.0 : -kToolbarHeight,
                    height: kToolbarHeight,
                    child: child!,
                  );
                },
                child: Row(
                  children: [
                    FloatingActionButton(
                      heroTag: 'fav_1',
                      backgroundColor: Colors.white,
                      onPressed: () {},
                      child: const Icon(
                        Icons.favorite_border,
                        color: Colors.black,
                      ),
                    ),
                    const Spacer(),
                    FloatingActionButton(
                      heroTag: 'fav_2',
                      backgroundColor: Colors.black,
                      onPressed: () {
                        context
                            .read<EnableButtonShopping>()
                            .setBoolButton(enableShopping: false);
                        _openShoppingCart(context);
                      },
                      child: const Icon(
                        Icons.shopping_cart_checkout_outlined,
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  ///Metodo para ir al panel, aparecer y desaparecer los FloatingActionButton
  Future<void> _openShoppingCart(BuildContext context) async {
    notifierButtonsVisible.value = false;

    await Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, animation1, __) {
          return FadeTransition(
            opacity: animation1,
            child: ShoppingCart(shoes: shoes),
          );
        },
      ),
    );
    notifierButtonsVisible.value = true;
  }

  ///Carrucel de las imagenes
  SizedBox _buildCarousel(Size size, BuildContext context) {
    return SizedBox(
        height: size.height * 0.5,
        child: Stack(
          children: [
            Positioned.fill(
              child: Hero(
                tag: 'bg_${shoes.model}',
                child: Container(
                  color: shoes.color,
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 70,
              left: 70,
              child: Hero(
                tag: 'number_${shoes.model}',
                child: ShakeTransition(
                  axis: Axis.vertical,
                  duration: const Duration(milliseconds: 1400),
                  offset: 10, //la distancia de rebote
                  child: Material(
                    color: Colors.transparent,
                    child: FittedBox(
                      child: Text(shoes.modelNumber.toString(),
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.05),
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
            ),
            PageView.builder(
              itemCount: shoes.images!.length,
              itemBuilder: (BuildContext context, int index) {
                // final tag = index == 0
                //     ? 'image_${shoes.model}'
                //     : 'image_${shoes.model}_$index';
                return Container(
                  alignment: Alignment.center,
                  child: Hero(
                    tag: 'image_${shoes.model}',
                    child: ShakeTransition(
                      duration: const Duration(milliseconds: 1300),
                      offset: 10,
                      axis: Axis.vertical,
                      child: Image.asset(
                        shoes.images![index],
                        height: 350,
                        width: 350,
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ));
  }
}

///Referente a las tallas
class _ShoesSizeItem extends StatelessWidget {
  final String text;
  const _ShoesSizeItem({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Text(
        'US $text',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 11,
        ),
      ),
    );
  }
}
