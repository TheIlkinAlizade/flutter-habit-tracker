import 'package:flutter/material.dart';
import '../../data/database.dart';
import '../../data/app_database_provider.dart';
import '../../data/icon_map.dart';
import 'heatmap_strip.dart';

enum HeatmapRange { week, month }

class TrackerCard extends StatefulWidget {
  final Tracker tracker;
  final VoidCallback onTap;

  const TrackerCard({super.key, required this.tracker, required this.onTap});

  @override
  State<TrackerCard> createState() => _TrackerCardState();
}

class _TrackerCardState extends State<TrackerCard> {
  HeatmapRange _range = HeatmapRange.month;

  String get _today {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _RangeChip(
                        label: 'Week',
                        selected: _range == HeatmapRange.week,
                        color: color,
                        onTap: () => setState(() => _range = HeatmapRange.week),
                      ),
                      const SizedBox(width: 6),
                      _RangeChip(
                        label: 'Month',
                        selected: _range == HeatmapRange.month,
                        color: color,
                        onTap: () => setState(() => _range = HeatmapRange.month),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  HeatmapStrip(
                    doneDates: doneDates,
                    color: color,
                    createdAt: DateTime.fromMillisecondsSinceEpoch(tracker.createdAt),
                    columns: _range == HeatmapRange.week ? 1 : 5,
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

class _RangeChip extends StatelessWidget {
  final String label;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  const _RangeChip({
    required this.label,
    required this.selected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: selected ? color.withValues(alpha: 0.2) : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: selected ? color : Colors.white38,
          ),
        ),
      ),
    );
  }
}