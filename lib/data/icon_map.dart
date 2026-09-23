import 'package:flutter/material.dart';

const trackerIconOptions = {
  'check': Icons.check,
  'book': Icons.menu_book,
  'code': Icons.code,
  'fitness': Icons.fitness_center,
  'brush': Icons.brush,
  'water': Icons.water_drop,
  'sleep': Icons.bedtime,
  'flag': Icons.flag,
};

IconData resolveTrackerIcon(String? key) {
  return trackerIconOptions[key] ?? Icons.check;
}