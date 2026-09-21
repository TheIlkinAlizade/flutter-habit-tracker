import 'package:flutter/material.dart';
import '../../data/database.dart';

class TrackerDetailScreen extends StatelessWidget {
  final Tracker tracker;

  const TrackerDetailScreen({super.key, required this.tracker});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tracker.name)),
      body: const Center(
        child: Text('Calendar view coming next', style: TextStyle(color: Colors.white54)),
      ),
    );
  }
}