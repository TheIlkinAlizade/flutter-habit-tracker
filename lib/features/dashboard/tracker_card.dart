import 'package:flutter/material.dart';
import '../../data/database.dart';
import '../../data/app_database_provider.dart';

class TrackerCard extends StatelessWidget {
  final Tracker tracker;
  final VoidCallback onTap;

  const TrackerCard({super.key, required this.tracker, required this.onTap});

  String get _today {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final color = Color(tracker.color);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: const Color(0xFF1A1A1D),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.check, color: color, size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  tracker.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              StreamBuilder<List<TrackerEntry>>(
                stream: database.entryDao.watchEntriesForTracker(tracker.id),
                builder: (context, snapshot) {
                  final entries = snapshot.data ?? [];
                  final doneToday = entries.any((e) => e.date == _today);
                  return GestureDetector(
                    onTap: () => database.entryDao
                        .toggleDay(tracker.id, _today, doneToday),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: doneToday ? color : Colors.white.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.check,
                        size: 18,
                        color: doneToday ? Colors.black : Colors.white38,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}