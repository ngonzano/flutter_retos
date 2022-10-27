import 'package:flutter/material.dart';
import 'package:flutter_retos/pages/staggered_dual_view.dart';

import '../animacion/clipper.dart';
import '../animacion/multiple_card_flow.dart';
import '../animacion/travel_photos.dart';
import '../home.dart';
import '../models/models.dart';
import '../nike/page/shoes_store.dart';
import '../widgets/widgets.dart';

class Approutes {
  static const initialRoute = 'home';

  static final menuOptions = <MenuOption>[
    //MenuOption(route: 'home', icon: Icons.home, screen: HomeScreen(), name: 'Home'),

    MenuOption(
        route: 'staggered_dual_view',
        icon: Icons.face,
        screen: const MainStaggeredDualView(),
        name: 'StaggeredDualView'),
    MenuOption(
        route: 'multipleCardFlow',
        icon: Icons.face,
        screen: const MultipleCardFlow(),
        name: 'MultipleCardFlow'),
    MenuOption(
        route: 'Clipper',
        icon: Icons.g_mobiledata,
        screen: const ClipperPage(),
        name: 'clipper'),
    MenuOption(
        route: 'travelPhotosHome',
        icon: Icons.g_mobiledata,
        screen: const TravelPhotosHome(),
        name: 'TravelPhotosHome'),
    MenuOption(
        route: 'TweenAnimationBuilder',
        icon: Icons.g_mobiledata,
        screen: const TextoAnimandose(),
        name: 'TweenAnimationBuilder<double>'),
    MenuOption(
        route: 'splashScreen',
        icon: Icons.g_mobiledata,
        screen: SplashScreen(),
        name: 'SplashScreen'),
    MenuOption(
        route: 'shoesStore',
        icon: Icons.directions_boat_filled,
        screen: ShoesStore(),
        name: 'Nike Shoes Store'),
    MenuOption(
        route: 'buttonEnable',
        icon: Icons.abc,
        screen: const ButtonEnable(),
        name: 'ButtonEnable'),
    MenuOption(
        route: 'buttonSnake',
        icon: Icons.baby_changing_station,
        screen: const BotonSnake(),
        name: 'ButtonSnake'),
    MenuOption(
        route: 'graficasCircularesPage',
        icon: Icons.cabin,
        screen: const GraficasCircularesPage(),
        name: 'GraficasCircularesPage'),
    MenuOption(
        route: 'bottonBarVisible',
        icon: Icons.dangerous,
        screen: BottonBarVisible(),
        name: 'BottonBarVisible'),
    MenuOption(
        route: 'listviewBuilderScreen',
        icon: Icons.face,
        screen: ListviewbuilderScreen(),
        name: 'ListviewbuilderScreen'),
  ];
//inicia aqui
  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};
    appRoutes.addAll({'home': (BuildContext context) => const HomeScreen()});

    for (final option in menuOptions) {
      appRoutes.addAll({option.route: (BuildContext context) => option.screen});
    }
    return appRoutes;
  }

//si hay error al iniciar muestra este page - podria ser un page como el 404
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    //para mostrar un page por defecto
    return MaterialPageRoute(builder: (context) => const HomeScreen());
  }
}
