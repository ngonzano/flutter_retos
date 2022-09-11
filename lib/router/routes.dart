import 'package:flutter/material.dart';

import '../home.dart';
import '../models/models.dart';
import '../nike/shoes_store.dart';

class Approutes {
  static const initialRoute = 'home';

  static final menuOptions = <MenuOption>[
    //MenuOption(route: 'home', icon: Icons.home, screen: HomeScreen(), name: 'Home'),

    MenuOption(
        route: 'shoesStore',
        icon: Icons.list_alt,
        screen: ShoesStore(),
        name: 'Nike Shoes Store'),
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
    return MaterialPageRoute(builder: (context) => HomeScreen());
  }
}
