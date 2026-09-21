import 'package:flutter/material.dart';
import 'data/app_database_provider.dart';

void main() {
  print(database);
  runApp(const MaterialApp(home: Scaffold(body: Center(child: Text('DB OK')))));
}