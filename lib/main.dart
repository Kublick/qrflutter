import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrsqlite/pages/home_page.dart';
import 'package:qrsqlite/pages/mapa_page.dart';
import 'package:qrsqlite/providers/ui_provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UiProvider())],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'QR Reader',
          initialRoute: 'home',
          routes: {
            'home': (_) => HomePage(),
            'mapa': (_) => MapaPage(),
          },
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
          )),
    );
  }
}
