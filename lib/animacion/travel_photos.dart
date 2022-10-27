import 'package:flutter/material.dart';
import 'package:flutter_retos/nike/provider/provider.dart';
import 'package:provider/provider.dart';

class TravelPhotosHome extends StatefulWidget {
  const TravelPhotosHome({Key? key}) : super(key: key);

  @override
  State<TravelPhotosHome> createState() => _TravelPhotosHomeState();
}

class _TravelPhotosHomeState extends State<TravelPhotosHome> {
  @override
  Widget build(BuildContext context) {
    EnableButtonShopping watch = context.watch<EnableButtonShopping>();

    final size = MediaQuery.of(context).size;
    final topCardHeight = size.height * 0.5;
    const horizontListHeight = 160.0;
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              height: topCardHeight,
              left: 0,
              right: 0,
              child: AnimatedContainer(
                color: watch.indexPage % 2 == 0 ? Colors.white : Colors.blue,
                duration: const Duration(milliseconds: 500),
                child: TravelPhotosListItem(
                  index: watch.indexPage,
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: topCardHeight - horizontListHeight * 0.5,
              height: horizontListHeight,
              child: TravelPhotosList(),
            ),
          ],
        ),
      ),
    );
  }
}

class TravelPhotosList extends StatefulWidget {
  TravelPhotosList({Key? key}) : super(key: key);

  @override
  State<TravelPhotosList> createState() => _TravelPhotosListState();
}

class _TravelPhotosListState extends State<TravelPhotosList> {
  final items = List.generate(10, ((index) => index));

  final _animatedListKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    EnableButtonShopping watch = context.watch<EnableButtonShopping>();
    return AnimatedList(
      key: _animatedListKey,
      physics: const PageScrollPhysics(),
      itemBuilder: (context, index, animation) {
        final itemInteger = items[index];
        return InkWell(
          onTap: () {
            final itemToDelete = itemInteger;

            items.removeAt(index);

            _animatedListKey.currentState?.removeItem(
              index,
              (context, animation) => FadeTransition(
                opacity: animation,
                child: SizeTransition(
                  sizeFactor: animation,
                  axis: Axis.horizontal,
                  child: TravelPhotosListItem(
                    index: itemToDelete,
                  ),
                ),
              ),
              duration: const Duration(milliseconds: 500),
            );
            items.insert(items.length, itemInteger);
            _animatedListKey.currentState?.insertItem(items.length - 1,
                duration: const Duration(milliseconds: 500));

            setState(() {
              context
                  .read<EnableButtonShopping>()
                  .setIndex(index: itemToDelete);
            });
          },
          child: TravelPhotosListItem(index: itemInteger),
        );
      },
      scrollDirection: Axis.horizontal,
      initialItemCount: items.length,
    );
  }
}

class TravelPhotosListItem extends StatelessWidget {
  const TravelPhotosListItem({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          color: Colors.primaries[index % Colors.primaries.length],
          width: 130,
          child: FittedBox(
            child: Text(index.toString()),
          ),
        ),
      ),
    );
  }
}
