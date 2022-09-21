import 'package:flutter/material.dart';

class ListviewbuilderScreen extends StatefulWidget {
  const ListviewbuilderScreen({Key? key}) : super(key: key);

  @override
  _ListviewbuilderScreenState createState() => _ListviewbuilderScreenState();
}

class _ListviewbuilderScreenState extends State<ListviewbuilderScreen> {
  final List<int> imageIds = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18
  ];
  final ScrollController scrollController = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      //print(' ${scrollController.position.pixels}, ${scrollController.position.maxScrollExtent} ');
      if (scrollController.position.pixels + 500 >=
          scrollController.position.maxScrollExtent) {
        //add5();
        fetcData();
      }
      // print(
      //     'scrollController.position.pixels: ${scrollController.position.maxScrollExtent}');
    });
  }

  Future fetcData() async {
    if (isLoading) return;

    isLoading = true;
    setState(() {});

    await Future.delayed(const Duration(seconds: 3));
    add5();

    isLoading = false;
    setState(() {});
    if (scrollController.position.pixels + 100 >=
        scrollController.position.maxScrollExtent) return;
    scrollController.animateTo(scrollController.position.pixels + 120,
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn);
  }

  void add5() {
    final lastId = imageIds.last;
    imageIds.addAll([
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10,
      11,
      12,
      13,
      14,
      15,
      16,
      17,
      18
    ].map((e) => lastId + e));
    setState(() {});
  }

  Future<void> onRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    final lastId = imageIds.last;
    imageIds.clear();
    imageIds.add(lastId + 1);
    add5();
  }

  bool listOrGrid = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            removeBottom: true,
            child: Stack(
              children: [
                RefreshIndicator(
                  color: Colors.deepPurple,
                  onRefresh: onRefresh,
                  child: listOrGrid
                      ? AnimatedSwitcher(
                          duration: const Duration(milliseconds: 1000),
                          child: Lista(
                              scrollController: scrollController,
                              imageIds: imageIds),
                        )
                      : AnimatedSwitcher(
                          duration: const Duration(milliseconds: 1000),
                          child: VistaCuadrilla(
                              scrollController: scrollController,
                              imageIds: imageIds),
                        ),
                ),
                if (isLoading)
                  Positioned(
                    bottom: 40,
                    left: size.width * 0.5 - 30,
                    child: const _LoadingIcon(),
                  )
              ],
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: IconButton(
                onPressed: () {
                  setState(() {
                    listOrGrid = !listOrGrid;
                  });
                },
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                )),
          ),
        ],
      ),
    );
  }
}

class VistaCuadrilla extends StatelessWidget {
  const VistaCuadrilla({
    Key? key,
    required this.scrollController,
    required this.imageIds,
  }) : super(key: key);

  final ScrollController scrollController;
  final List<int> imageIds;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        // physics: const BouncingScrollPhysics(),
        physics: const PageScrollPhysics(),
        controller: scrollController,
        itemCount: imageIds.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 0.0,
            crossAxisSpacing: 0.0,
            mainAxisExtent: 100),
        itemBuilder: (_, index) {
          return FadeInImage(
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
              placeholder: const AssetImage('assets/img/loading.gif'),
              image: NetworkImage(
                  'https://picsum.photos/500/200?image=${imageIds[index]}'));
        });
  }
}

class Lista extends StatelessWidget {
  const Lista({
    Key? key,
    required this.scrollController,
    required this.imageIds,
  }) : super(key: key);

  final ScrollController scrollController;
  final List<int> imageIds;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      ///para el mismo efecto de IOS en Android
      // physics: const BouncingScrollPhysics(),
      physics: const PageScrollPhysics(),
      controller: scrollController,
      itemCount: imageIds.length,
      itemBuilder: (BuildContext context, int index) {
        return FadeInImage(
            width: double.infinity,
            height: 300,
            fit: BoxFit.cover,
            placeholder: const AssetImage('assets/img/loading.gif'),
            image: NetworkImage(
                'https://picsum.photos/500/200?image=${imageIds[index]}'));
      },
    );
  }
}

class _LoadingIcon extends StatelessWidget {
  const _LoadingIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 60,
      width: 60,
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9), shape: BoxShape.circle),
      //child: const CircularProgressIndicator(color: AppTheme.primary),
      child: const CircularProgressIndicator.adaptive(
          backgroundColor: Colors.deepPurple),
    );
  }
}
