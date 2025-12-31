import 'package:flutter/material.dart';
import 'package:freedomcore/utils/global_keys.dart';
import 'package:freedomcore/themes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//pages
import 'package:freedomcore/pages/ble.dart';
import 'package:freedomcore/pages/home.dart';
import 'package:freedomcore/pages/serial.dart';
//providers
import 'package:freedomcore/providers/meshcode_provider.dart';

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
      '/ble': (context) => BlePage(),
      '/serial': (context) => SerialConnectionPage(), 
    },
  ); // MaterialApp
}
}
