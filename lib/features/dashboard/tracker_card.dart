import 'package:flutter/material.dart';
import '../../data/database.dart';
import '../../data/app_database_provider.dart';
import 'heatmap_strip.dart';
import '../../data/icon_map.dart';

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
          child: StreamBuilder<List<TrackerEntry>>(
            stream: database.entryDao.watchEntriesForTracker(tracker.id),
            builder: (context, snapshot) {
              final entries = snapshot.data ?? [];
              final doneDates = entries.map((e) => e.date).toSet();
              final doneToday = doneDates.contains(_today);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: Icon(resolveTrackerIcon(tracker.icon), color: color, size: 18),
                      ),
                      const SizedBox(width: 12),
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
                      GestureDetector(
                        onTap: () => database.entryDao
                            .toggleDay(tracker.id, _today, doneToday),
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: doneToday ? color : Colors.white.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.check,
                            size: 16,
                            color: doneToday ? Colors.black : Colors.white38,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  HeatmapStrip(doneDates: doneDates, color: color),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}