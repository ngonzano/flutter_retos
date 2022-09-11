import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'nike/provider/provider.dart';
import 'router/routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Material App',
          initialRoute: Approutes.initialRoute,
          routes: Approutes.getAppRoutes(),
          onGenerateRoute: Approutes.onGenerateRoute,
          // theme: AppTheme.lightTheme,
          //theme:  AppTheme.darkTheme,
        );
      },
      providers: [
        ChangeNotifierProvider<EnableButtonShopping>(
            create: (_) => EnableButtonShopping())
      ],
    );
  }
}
