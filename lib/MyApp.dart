import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:gender_prediction/GP.dart';
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gender Prediction App',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: GenderPredictionPage(),
    );
  }
}
