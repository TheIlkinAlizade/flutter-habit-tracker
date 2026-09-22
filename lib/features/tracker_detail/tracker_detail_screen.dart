import 'package:flutter/material.dart';
import '../../data/app_database_provider.dart';
import '../../data/database.dart';
import 'calendar_grid.dart';

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
      appBar: AppBar(title: Text(widget.tracker.name)),
      body: StreamBuilder<List<TrackerEntry>>(
        stream: database.entryDao.watchEntriesForTracker(widget.tracker.id),
        builder: (context, snapshot) {
          final entries = snapshot.data ?? [];
          final doneDates = entries.map((e) => e.date).toSet();

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
              Expanded(
                child: CalendarGrid(
                  visibleMonth: _visibleMonth,
                  doneDates: doneDates,
                  color: color,
                  onDayTap: (dateStr, currentlyDone) {
                    database.entryDao
                        .toggleDay(widget.tracker.id, dateStr, currentlyDone);
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