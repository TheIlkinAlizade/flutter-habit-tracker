import 'package:flutter/material.dart';
import '../../data/app_database_provider.dart';
import '../../data/database.dart';
import '../tracker_form/tracker_form_screen.dart';
import '../tracker_detail/tracker_detail_screen.dart';
import 'tracker_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Habit Tracker')),
      body: StreamBuilder<List<Tracker>>(
        stream: database.trackerDao.watchActiveTrackers(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final trackers = snapshot.data!;
          if (trackers.isEmpty) {
            return const Center(
              child: Text(
                'No trackers yet.\nTap + to add one.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white54, fontSize: 16),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: trackers.length,
            itemBuilder: (context, index) {
              final tracker = trackers[index];
              return TrackerCard(
                tracker: tracker,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TrackerDetailScreen(tracker: tracker),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const TrackerFormScreen()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}