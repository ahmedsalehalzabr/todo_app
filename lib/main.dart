import 'package:appnews/addnotes.dart';
import 'package:flutter/material.dart';

import 'package:appnews/home.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO APP',
      debugShowCheckedModeBanner: false,

      home: Home(),
      routes: {"addnotes": (context) => AddNotes()},
    );
  }
}
