import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hotelflutter/add_room_widget.dart';
import 'package:hotelflutter/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hotelflutter/home_screen.dart';
import 'package:hotelflutter/loginA.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp(
   // home: AddRoomWidget(), // Wrap AddRoomWidget with MaterialApp
    //home: HomeScreen(),
    home: logA(),
  ));
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home: AddRoomWidget(),
    );
  }
}