import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:prioritas1/page/GaleryScreen.dart';

import './page/MaterialScreen.dart';
import './page/SettingScreen.dart';
import './provider/theme_Provider.dart';
void main() {
  runApp(
    MultiProvider(
      providers: [
      ChangeNotifierProvider(create: (_)=> ThemeProvider()),      
    ],
    child: MyApp()),
    
    );
}

class MyApp extends StatelessWidget {
  final Map<String, WidgetBuilder> routes = {
    '/': (context) => MaterialScreen(),
    '/settings': (context) => SettingsScreen(),
    '/gallery': (context) => GalleryScreen(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: '/',
      routes: routes,
    );
  }
}
