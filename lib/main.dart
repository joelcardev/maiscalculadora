import 'package:flutter/material.dart';
import 'package:maiscalculadora/telas/telaHome.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

///FUNÇÃO QUE DESABILITA A POSSIBILIDADE DE ROTAÇÃO DO CELULAR, ISSO IMPEDIRA DE PROVOCAR FUTUROS ERROS.
void _portraitModeOnly() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    _portraitModeOnly();

    return MaterialApp(

        ///BLOCO DE CODIGOS PARA DEFINIR A RESPONSIVIDADE DO APP.
        builder: (context, widget) => ResponsiveWrapper.builder(
                ClampingScrollWrapper.builder(context, widget),
                maxWidth: 1200,
                minWidth: 370,
                defaultScale: true,
                breakpoints: [
                  ResponsiveBreakpoint.resize(370, name: MOBILE),
                  ResponsiveBreakpoint.autoScale(600, name: TABLET),
                  ResponsiveBreakpoint.resize(1200, name: DESKTOP),
                ]),
        title: '+ Calculadora',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: telaHome());
  }
}
