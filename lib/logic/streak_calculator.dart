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