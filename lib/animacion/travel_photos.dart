import 'package:flutter/material.dart';

class TravelPhotosHome extends StatelessWidget {
  const TravelPhotosHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              child: const Placeholder(),
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

class TravelPhotosList extends StatelessWidget {
  TravelPhotosList({Key? key}) : super(key: key);

  final items = List.generate(10, ((index) => index));
  final _animatedListKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
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
