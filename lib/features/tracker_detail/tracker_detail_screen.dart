import 'package:flutter/material.dart';
import '../../data/app_database_provider.dart';
import '../../data/database.dart';
import 'calendar_grid.dart';
import '../../logic/streak_calculator.dart';
import '../stats/stats_screen.dart';
import '../tracker_form/tracker_form_screen.dart';

class TrackerDetailScreen extends StatefulWidget {
  final Tracker tracker;

  const TrackerDetailScreen({super.key, required this.tracker});

  @override
  State<TrackerDetailScreen> createState() => _TrackerDetailScreenState();
}

class _TrackerDetailScreenState extends State<TrackerDetailScreen> {
  late DateTime _visibleMonth;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _visibleMonth = DateTime(now.year, now.month);
  }

  void _shiftMonth(int delta) {
    setState(() {
      _visibleMonth = DateTime(_visibleMonth.year, _visibleMonth.month + delta);
    });
  }

  @override
  Widget build(BuildContext context) {
    final color = Color(widget.tracker.color);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tracker.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => TrackerFormScreen(existingTracker: widget.tracker),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => StatsScreen(tracker: widget.tracker)),
            ),
          ),
        ],
      ),
      body: StreamBuilder<List<TrackerEntry>>(
        stream: database.entryDao.watchEntriesForTracker(widget.tracker.id),
        builder: (context, snapshot) {
          final entries = snapshot.data ?? [];
          final doneDates = entries.map((e) => e.date).toSet();

          final streaks = calculateStreaks(
            doneDates: doneDates,
            scheduleType: widget.tracker.scheduleType,
            scheduleConfig: widget.tracker.scheduleConfig,
            today: DateTime.now(),
          );

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left),
                      onPressed: () => _shiftMonth(-1),
                    ),
                    Text(
                      _monthLabel(_visibleMonth),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right),
                      onPressed: () => _shiftMonth(1),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Row(
                  children: [
                    _StreakBadge(label: 'Current', value: streaks.currentStreak, color: color),
                    const SizedBox(width: 12),
                    _StreakBadge(label: 'Longest', value: streaks.longestStreak, color: color),
                  ],
                ),
              ),
              Expanded(
                child: CalendarGrid(
                  visibleMonth: _visibleMonth,
                  doneDates: doneDates,
                  color: color,
                  createdAt: DateTime.fromMillisecondsSinceEpoch(widget.tracker.createdAt),
                  onDayTap: (dateStr, currentlyDone) {
                    database.entryDao.toggleDay(widget.tracker.id, dateStr, currentlyDone);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _monthLabel(DateTime d) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December',
    ];
    return '${months[d.month - 1]} ${d.year}';
  }
}

class _StreakBadge extends StatelessWidget {
  final String label;
  final int value;
  final Color color;

  const _StreakBadge({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1D),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text('$value', style: TextStyle(color: color, fontSize: 22, fontWeight: FontWeight.bold)),
            Text(label, style: const TextStyle(color: Colors.white38, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}