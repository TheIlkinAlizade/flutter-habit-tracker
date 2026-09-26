import 'package:flutter/material.dart';
import '../../data/database.dart';
import '../../data/app_database_provider.dart';
import '../../data/icon_map.dart';
import '../../logic/streak_calculator.dart';
import 'heatmap_strip.dart';

class TrackerCard extends StatefulWidget {
  final Tracker tracker;
  final VoidCallback onTap;

  const TrackerCard({super.key, required this.tracker, required this.onTap});

  @override
  State<TrackerCard> createState() => _TrackerCardState();
}

class _TrackerCardState extends State<TrackerCard> {
  HeatmapRange _range = HeatmapRange.year;

  String get _today {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  String _rangeLabel(HeatmapRange r) {
    switch (r) {
      case HeatmapRange.week:
        return 'Week';
      case HeatmapRange.month:
        return 'Month';
      case HeatmapRange.year:
        return 'Year';
    }
  }

  @override
  Widget build(BuildContext context) {
    final tracker = widget.tracker;
    final color = Color(tracker.color);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: const Color(0xFF1A1A1D),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: StreamBuilder<List<TrackerEntry>>(
            stream: database.entryDao.watchEntriesForTracker(tracker.id),
            builder: (context, snapshot) {
              final entries = snapshot.data ?? [];
              final doneDates = entries.map((e) => e.date).toSet();
              final doneToday = doneDates.contains(_today);
              final isDueToday = !doneToday &&
                isScheduledDay(DateTime.now(), tracker.scheduleType, tracker.scheduleConfig);

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
                            color: doneToday
                                ? color
                                : (isDueToday
                                    ? const Color(0xFFFFC107).withValues(alpha: 0.18)
                                    : Colors.white.withValues(alpha: 0.08)),
                            borderRadius: BorderRadius.circular(8),
                            border: (!doneToday && isDueToday)
                                ? Border.all(color: const Color(0xFFFFC107), width: 1.5)
                                : null,
                          ),
                          child: Icon(
                            Icons.check,
                            size: 16,
                            color: doneToday
                                ? Colors.black
                                : (isDueToday ? const Color(0xFFFFC107) : Colors.white38),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      PopupMenuButton<HeatmapRange>(
                        color: const Color(0xFF232326),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        onSelected: (value) => setState(() => _range = value),
                        itemBuilder: (context) => HeatmapRange.values.map((r) {
                          return PopupMenuItem(
                            value: r,
                            child: Text(
                              _rangeLabel(r),
                              style: TextStyle(
                                color: r == _range ? color : Colors.white70,
                                fontWeight: r == _range ? FontWeight.w600 : FontWeight.normal,
                              ),
                            ),
                          );
                        }).toList(),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _rangeLabel(_range),
                              style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600),
                            ),
                            Icon(Icons.expand_more, size: 16, color: color),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  HeatmapStrip(
                    doneDates: doneDates,
                    color: color,
                    createdAt: DateTime.fromMillisecondsSinceEpoch(tracker.createdAt),
                    range: _range,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}