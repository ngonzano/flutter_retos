import 'package:flutter/material.dart';

class AppTheme{
  static const Color primary = Colors.green;
  static Color secundario = Colors.green.shade900;

  static final ThemeData lightTheme = ThemeData.light().copyWith(
        //Color Primario
        primaryColor: Colors.indigo,
        //App Bar Theme
        appBarTheme: AppBarTheme(
          color: primary,
          elevation: 1
        ),
        //para los botones de text ejm: ok, cancel, aceptar
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom( primary: primary)
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: primary
        ),
        //estilo del boton
        elevatedButtonTheme: ElevatedButtonThemeData(
           style: ElevatedButton.styleFrom(
             primary: Colors.green,
             shape: const StadiumBorder(),
             elevation: 0
           ),
        ),
        //para los inputs
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: secundario),//color de la letra que se encuentra contenido en el input
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: secundario),//Color de la letra por defecto que se oculta al hacer foco
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                topLeft: Radius.circular(10)
                )
              ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: primary),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)
                )
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)
                )
                )
        )
      );
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
        //Color Primario
        primaryColor: Colors.indigo,
        //App Bar Theme
        appBarTheme: AppBarTheme(
          color: primary,
          elevation: 1
        ),
        scaffoldBackgroundColor: Colors.grey[1000],//para cambiarle de color al fondo cuando es tema oscuro
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom( primary: primary)
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: primary
          ),
        elevatedButtonTheme: ElevatedButtonThemeData(
           style: ElevatedButton.styleFrom(
             primary: Colors.green,
             shape: const StadiumBorder(),
             elevation: 0
           ),
          )
      );
}