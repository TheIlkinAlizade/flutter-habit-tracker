import 'package:flutter/material.dart';
import '../../data/app_database_provider.dart';
import '../../data/database.dart';
import '../../logic/streak_calculator.dart';
import '../../data/icon_map.dart';

class QuickTickScreen extends StatelessWidget {
  const QuickTickScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Tracker>>(
        stream: database.trackerDao.watchActiveTrackers(),
        builder: (context, snapshot) {
          final trackers = snapshot.data ?? [];

          if (trackers.isEmpty) {
            return const Center(
              child: Text(
                'No trackers yet.',
                style: TextStyle(color: Colors.white54, fontSize: 16),
              ),
            );
          }

          return PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: trackers.length,
            itemBuilder: (context, index) {
              return _QuickTickCard(tracker: trackers[index]);
            },
          );
        },
      ),
    );
  }
}

class _QuickTickCard extends StatelessWidget {
  final Tracker tracker;

  const _QuickTickCard({required this.tracker});

  String get _today {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final color = Color(tracker.color);

    return StreamBuilder<List<TrackerEntry>>(
      stream: database.entryDao.watchEntriesForTracker(tracker.id),
      builder: (context, snapshot) {
        final entries = snapshot.data ?? [];
        final doneDates = entries.map((e) => e.date).toSet();
        final doneToday = doneDates.contains(_today);
        final isDueToday = !doneToday &&
          isScheduledDay(DateTime.now(), tracker.scheduleType, tracker.scheduleConfig);

        final streaks = calculateStreaks(
          doneDates: doneDates,
          scheduleType: tracker.scheduleType,
          scheduleConfig: tracker.scheduleConfig,
          today: DateTime.now(),
        );

        return Container(
          color: const Color(0xFF0D0D0F),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  tracker.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${streaks.currentStreak} day streak',
                  style: const TextStyle(color: Colors.white54, fontSize: 15),
                ),
                const SizedBox(height: 48),
                GestureDetector(
                  onTap: () => database.entryDao
                      .toggleDay(tracker.id, _today, doneToday),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      color: doneToday
                          ? color
                          : (isDueToday
                              ? const Color(0xFFFFC107).withValues(alpha: 0.12)
                              : Colors.white.withValues(alpha: 0.06)),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: doneToday
                            ? color
                            : (isDueToday ? const Color(0xFFFFC107) : Colors.white24),
                        width: 3,
                      ),
                    ),
                  child: Icon(
                    doneToday ? Icons.check : resolveTrackerIcon(tracker.icon),
                    size: 72,
                    color: doneToday ? Colors.black : Colors.white38,
                  ),
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  doneToday
                      ? 'Done for today'
                      : (isDueToday ? 'Scheduled for today' : 'Tap to mark done'),
                  style: TextStyle(
                    color: isDueToday && !doneToday ? const Color(0xFFFFC107) : Colors.white38,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 64),
                const Icon(Icons.keyboard_arrow_up, color: Colors.white24),
                const Text(
                  'Swipe for next',
                  style: TextStyle(color: Colors.white24, fontSize: 12),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}