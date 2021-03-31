import 'package:flutter/material.dart';
import './views/ROIForm.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Simple Halal Gold Calculator App",
      home: ROIForm(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.green,
          accentColor: Colors.greenAccent,
          primarySwatch: Colors.green,
          fontFamily: "ProductSans",
          textTheme:
              TextTheme(headline6: TextStyle(fontWeight: FontWeight.w900))),
    );
  }
}
