import 'package:flutter/material.dart';
import 'package:habitmanager1/screens/homepage.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}