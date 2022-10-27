import 'package:flutter/material.dart';

class MainStaggeredDualView extends StatelessWidget {
  const MainStaggeredDualView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Icon(
            Icons.shield_moon_sharp,
            color: Colors.red,
            size: 50,
          ),
        ],
        leading: const Icon(
          Icons.scatter_plot_rounded,
          size: 50,
          color: Colors.deepPurple,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Meals",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: StaggeredDualView(),
    );
  }
}

class StaggeredDualView extends StatelessWidget {
  const StaggeredDualView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
