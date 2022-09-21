import 'package:flutter/material.dart';

class BottonBarVisible extends StatelessWidget {
  final ValueNotifier<bool> notifierButtonsVisible = ValueNotifier(false);
  BottonBarVisible({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //cuando el widget ya fue mostrado que recien aparezca
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifierButtonsVisible.value = true; //esto lo hace aparecer
    });
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.grey,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ValueListenableBuilder(
              builder: (BuildContext context, value, Widget? child) {
                value as bool;
                return AnimatedPositioned(
                  duration: const Duration(milliseconds: 500),
                  left: 0,
                  right: 0,
                  bottom: value ? 10.0 : -kToolbarHeight,
                  height: kToolbarHeight,
                  child: child!,
                );
              },
              valueListenable: notifierButtonsVisible,
              child: FloatingActionButton(
                heroTag: 'fav_2',
                backgroundColor: Colors.black,
                onPressed: () {
                  _openShoppingCart(context);
                },
                child: const Icon(
                  Icons.shopping_cart_checkout_outlined,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openShoppingCart(BuildContext context) async {
    notifierButtonsVisible.value = false;
    await Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, animation1, __) {
          return FadeTransition(
              opacity: animation1,
              child: Scaffold(
                appBar: AppBar(),
              ));
        },
      ),
    );
    notifierButtonsVisible.value = true;
  }
}
