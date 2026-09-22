class StreakResult {
  final int currentStreak;
  final int longestStreak;

  const StreakResult({required this.currentStreak, required this.longestStreak});
}

bool isScheduledDay(DateTime date, String scheduleType, String? scheduleConfig) {
  switch (scheduleType) {
    case 'daily':
      return true;
    case 'weekly_days':
      if (scheduleConfig == null || scheduleConfig.isEmpty) return true;
      final activeDays = scheduleConfig.split(',').map(int.parse).toSet();
      return activeDays.contains(date.weekday);
    case 'monthly':
      if (scheduleConfig == null || scheduleConfig.isEmpty) return true;
      final targetDay = int.parse(scheduleConfig);
      return date.day == targetDay;
    default:
      return true;
  }
}

StreakResult calculateStreaks({
  required Set<String> doneDates,
  required String scheduleType,
  required String? scheduleConfig,
  required DateTime today,
}) {
  if (doneDates.isEmpty) {
    return const StreakResult(currentStreak: 0, longestStreak: 0);
  }

  final sortedDates = doneDates.toList()..sort();
  final firstDone = _parseDate(sortedDates.first);

  int longestStreak = 0;
  int runningStreak = 0;
  DateTime cursor = firstDone;
  final todayNormalized = DateTime(today.year, today.month, today.day);

  while (!cursor.isAfter(todayNormalized)) {
    if (isScheduledDay(cursor, scheduleType, scheduleConfig)) {
      final dateStr = _formatDate(cursor);
      if (doneDates.contains(dateStr)) {
        runningStreak++;
        if (runningStreak > longestStreak) longestStreak = runningStreak;
      } else {
        runningStreak = 0;
      }
    }
    cursor = cursor.add(const Duration(days: 1));
  }

  int currentStreak = 0;
  cursor = todayNormalized;
  while (true) {
    if (isScheduledDay(cursor, scheduleType, scheduleConfig)) {
      final dateStr = _formatDate(cursor);
      if (doneDates.contains(dateStr)) {
        currentStreak++;
      } else {
        break;
      }
    }
    cursor = cursor.subtract(const Duration(days: 1));
    if (cursor.isBefore(firstDone)) break;
  }

  return StreakResult(currentStreak: currentStreak, longestStreak: longestStreak);
}

DateTime _parseDate(String dateStr) {
  final parts = dateStr.split('-');
  return DateTime(int.parse(parts[0]), int.parse(parts[1]), int.parse(parts[2]));
}

String _formatDate(DateTime date) {
  final m = date.month.toString().padLeft(2, '0');
  final d = date.day.toString().padLeft(2, '0');
  return '${date.year}-$m-$d';
}

class MonthStats {
  final int completedCount;
  final int scheduledCount;
  final double completionPercent;

  const MonthStats({
    required this.completedCount,
    required this.scheduledCount,
    required this.completionPercent,
  });
}

MonthStats calculateMonthStats({
  required Set<String> doneDates,
  required String scheduleType,
  required String? scheduleConfig,
  required DateTime month,
  required DateTime today,
}) {
  final isCurrentMonth = month.year == today.year && month.month == today.month;
  final lastDayToCheck = isCurrentMonth
      ? today.day
      : DateTime(month.year, month.month + 1, 0).day;

  int completed = 0;
  int scheduled = 0;

  for (int day = 1; day <= lastDayToCheck; day++) {
    final date = DateTime(month.year, month.month, day);
    if (!isScheduledDay(date, scheduleType, scheduleConfig)) continue;

    scheduled++;
    final dateStr = _formatDate(date);
    if (doneDates.contains(dateStr)) completed++;
  }

  final percent = scheduled == 0 ? 0.0 : completed / scheduled;

  return MonthStats(
    completedCount: completed,
    scheduledCount: scheduled,
    completionPercent: percent,
  );
}

int calculateTotalDaysTracked(Set<String> doneDates) => doneDates.length;