import 'package:flutter/material.dart';
import '../../data/app_database_provider.dart';
import '../../data/database.dart';
import '../../logic/streak_calculator.dart';

class StatsScreen extends StatelessWidget {
  final Tracker tracker;

  const StatsScreen({super.key, required this.tracker});

  @override
  Widget build(BuildContext context) {
    final color = Color(tracker.color);
    final now = DateTime.now();

    return Scaffold(
      appBar: AppBar(title: Text('${tracker.name} — Stats')),
      body: StreamBuilder<List<TrackerEntry>>(
        stream: database.entryDao.watchEntriesForTracker(tracker.id),
        builder: (context, snapshot) {
          final entries = snapshot.data ?? [];
          final doneDates = entries.map((e) => e.date).toSet();

          final monthStats = calculateMonthStats(
            doneDates: doneDates,
            scheduleType: tracker.scheduleType,
            scheduleConfig: tracker.scheduleConfig,
            month: DateTime(now.year, now.month),
            today: now,
          );

          final streaks = calculateStreaks(
            doneDates: doneDates,
            scheduleType: tracker.scheduleType,
            scheduleConfig: tracker.scheduleConfig,
            today: now,
          );

          final totalDays = calculateTotalDaysTracked(doneDates);

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _StatTile(
                  label: 'This month',
                  value: '${(monthStats.completionPercent * 100).round()}%',
                  sub: '${monthStats.completedCount} of ${monthStats.scheduledCount} scheduled days',
                  color: color,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _StatTile(
                        label: 'Current streak',
                        value: '${streaks.currentStreak}',
                        sub: streaks.currentStreak == 1 ? 'day' : 'days',
                        color: color,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatTile(
                        label: 'Longest streak',
                        value: '${streaks.longestStreak}',
                        sub: streaks.longestStreak == 1 ? 'day' : 'days',
                        color: color,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _StatTile(
                  label: 'Total days tracked',
                  value: '$totalDays',
                  sub: 'since ${_since(tracker.createdAt)}',
                  color: color,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _since(int createdAtMillis) {
    final d = DateTime.fromMillisecondsSinceEpoch(createdAtMillis);
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${months[d.month - 1]} ${d.year}';
  }
}

class _StatTile extends StatelessWidget {
  final String label;
  final String value;
  final String sub;
  final Color color;

  const _StatTile({
    required this.label,
    required this.value,
    required this.sub,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1D),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.white54, fontSize: 13)),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(color: color, fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 2),
          Text(sub, style: const TextStyle(color: Colors.white38, fontSize: 12)),
        ],
      ),
    );
  }
}