import 'package:flutter/material.dart';
import 'package:OSMCore/utils/global_keys.dart';
import 'package:OSMCore/themes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//pages
import 'package:OSMCore/pages/ble.dart';
import 'package:OSMCore/pages/home.dart';
import 'package:OSMCore/pages/serial.dart';
import 'package:OSMCore/pages/test.dart';
//providers
import 'package:OSMCore/providers/meshcode_provider.dart';

void main(){
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget { 
  const MyApp({super.key});

@override
Widget build(BuildContext context){
  return MaterialApp(
    title: 'Flutter Demo',
    theme: AppTheme.light,
    darkTheme: AppTheme.dark,
    scaffoldMessengerKey: scaffoldMessengerKey,
    debugShowCheckedModeBanner: false,
    home: HomePage(),
    routes: {
      '/home': (context) => HomePage(),
      //'/ble': (context) => BlePage(),
      '/test': (context) => TestPage(),
      '/serial': (context) => SerialConnectionPage(),
    },
  ); // MaterialApp
}
}
