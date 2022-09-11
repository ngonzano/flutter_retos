import 'package:flutter/material.dart';
import 'model/model_shoes_store.dart';
import 'shoes_detail.dart';

class ShoesStore extends StatelessWidget {
  ShoesStore({Key? key}) : super(key: key);

  ///para no usar un setState y sea animado el menu con un cambio de estado
  final ValueNotifier<bool> notifierBottomBarVisible = ValueNotifier(true);

  ///Metodo para cambiar de page y desaparecer el menu animado
  void _onShoesPressed(Shoes shoes, BuildContext context) async {
    notifierBottomBarVisible.value = false; //desaparece el menu
    await Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) {
          return FadeTransition(
            opacity: animation1,
            child: ShoesDetails(
              shoes: shoes,
            ),
          );
        },
      ),
    );
    notifierBottomBarVisible.value = true; //visible el menu
  }

  ///Show all data in page
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('NIKE'),
          foregroundColor: Colors.black,
          leading: const BackButton(color: Colors.black),
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          actions: [
            Image.network(
              width: 50,
              height: 50,
              'https://graffica.info/wp-content/uploads/2022/04/logotipo-nike-838x285x80xX.jpeg',
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
              child: Column(
                children: [
                  Expanded(
                    ///Show all items in page
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      itemCount: shoes.length,
                      itemBuilder: (context, index) {
                        final shoesItem = shoes[index]; //get data
                        return _ShoesItem(
                          shoesItem: shoesItem,
                          onTap: () {
                            _onShoesPressed(shoesItem, context);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            ///para escuchar al ValueNotifier<bool> notifierBottomBarVisible
            ///notifierBottomBarVisible cuando cambia viene aqui y se vuelve a
            ///dibujar

            ValueListenableBuilder(
              valueListenable: notifierBottomBarVisible,
              builder: (BuildContext context, value, Widget? child) {
                value as bool;
                return AnimatedPositioned(
                    left: 0,
                    right: 0,
                    bottom: value
                        ? 0.0
                        : -kToolbarHeight, //para hacer el cambio sin setState
                    height: kToolbarHeight,
                    duration: const Duration(milliseconds: 400),
                    child: child!);
              },
              child: Container(
                color: Colors.white.withOpacity(0.7),
                child: Row(
                  children: const [
                    Expanded(
                      child: Icon(Icons.home),
                    ),
                    Expanded(
                      child: Icon(Icons.search),
                    ),
                    Expanded(
                      child: Icon(Icons.favorite_border),
                    ),
                    Expanded(
                      child: Icon(Icons.shopping_cart_outlined),
                    ),
                    Expanded(
                      child: Center(
                        child: CircleAvatar(
                          radius: 13,
                          backgroundImage:
                              NetworkImage('http://placeimg.com/640/480/tech'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

///Data Item(image and text)
class _ShoesItem extends StatelessWidget {
  final Shoes shoesItem;
  final VoidCallback onTap;
  const _ShoesItem({Key? key, required this.shoesItem, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const itemHeight = 300.0;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: itemHeight,
          child: Stack(
            children: [
              Hero(
                tag: 'bg_${shoesItem.model}',
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: shoesItem.color,
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 70,
                left: 70,
                child: Hero(
                  tag: 'number_${shoesItem.model}',
                  child: SizedBox(
                    height: itemHeight * 0.6,
                    child: Material(
                      color: Colors.transparent,
                      child: FittedBox(
                        child: Text(
                          shoesItem.modelNumber.toString(),
                          style: TextStyle(
                              color: Colors.black12.withOpacity(0.05),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                height: itemHeight * 0.65,
                width: itemHeight * 0.65,
                top: 20,
                left: MediaQuery.of(context).size.width * 0.2,
                child: Hero(
                  tag: 'image_${shoesItem.model}',
                  child: Image.asset(
                    shoesItem.images!.first,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const Positioned(
                bottom: 20,
                right: 20,
                child: Icon(
                  Icons.shopping_bag_outlined,
                  color: Colors.grey,
                ),
              ),
              const Positioned(
                bottom: 20,
                left: 20,
                child: Icon(
                  Icons.favorite_border_outlined,
                  color: Colors.grey,
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 25,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      shoesItem.model!,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'S/. ${shoesItem.oldPrice!.toInt().toString()}',
                      style: const TextStyle(
                          color: Colors.red,
                          decoration: TextDecoration.lineThrough),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'S/. ${shoesItem.currentPrice!.toInt().toString()}',
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
