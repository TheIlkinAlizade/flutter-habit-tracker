import 'package:flutter/material.dart';

class CalendarGrid extends StatelessWidget {
  final DateTime visibleMonth;
  final Set<String> doneDates;
  final Color color;
  final void Function(String dateStr, bool currentlyDone) onDayTap;

  const CalendarGrid({
    super.key,
    required this.visibleMonth,
    required this.doneDates,
    required this.color,
    required this.onDayTap,
  });

  String _dateStr(int day) {
    final m = visibleMonth.month.toString().padLeft(2, '0');
    final d = day.toString().padLeft(2, '0');
    return '${visibleMonth.year}-$m-$d';
  }

  @override
  Widget build(BuildContext context) {
    final firstOfMonth = DateTime(visibleMonth.year, visibleMonth.month, 1);
    final daysInMonth = DateTime(visibleMonth.year, visibleMonth.month + 1, 0).day;
    final leadingBlanks = (firstOfMonth.weekday - 1) % 7;

    final todayStr = () {
      final now = DateTime.now();
      return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    }();

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            children: const ['M', 'T', 'W', 'T', 'F', 'S', 'S']
                .map((label) => Expanded(
                      child: Center(
                        child: Text(
                          label,
                          style: const TextStyle(color: Colors.white38, fontSize: 12),
                        ),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisSpacing: 6,
                crossAxisSpacing: 6,
              ),
              itemCount: leadingBlanks + daysInMonth,
              itemBuilder: (context, index) {
                if (index < leadingBlanks) return const SizedBox.shrink();

                final day = index - leadingBlanks + 1;
                final dateStr = _dateStr(day);
                final isDone = doneDates.contains(dateStr);
                final isToday = dateStr == todayStr;
                final isFuture = dateStr.compareTo(todayStr) > 0;

                return GestureDetector(
                  onTap: isFuture ? null : () => onDayTap(dateStr, isDone),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDone
                          ? color
                          : Colors.white.withOpacity(isFuture ? 0.03 : 0.06),
                      borderRadius: BorderRadius.circular(8),
                      border: isToday
                          ? Border.all(color: Colors.white, width: 1.5)
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        '$day',
                        style: TextStyle(
                          color: isDone
                              ? Colors.black
                              : (isFuture ? Colors.white24 : Colors.white70),
                          fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}