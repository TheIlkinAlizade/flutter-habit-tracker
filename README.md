# Habit Tracker

A habit and streak tracker built with Flutter. Create trackers for anything — reading, studying, exercise, side projects — tick off days on a calendar, and see streaks and stats build up over time.

Everything is stored locally with SQLite. No account, no server, no sync.

## Features

- Create trackers with a name, color, icon, and repeat schedule (every day, specific weekdays, or a day of the month)
- Tap any day on a calendar to mark it done or undone — past days included, nothing is locked
- Current streak and longest streak per tracker, aware of the tracker's schedule
- Completion percentage for the current month, total days tracked
- Dashboard heatmap per tracker, similar to a GitHub contributions graph
- A quick-tick screen for marking today's trackers done one after another

## Stack

- Flutter
- [drift](https://drift.simonbinder.eu/) (SQLite) for storage, with reactive streams instead of manual refresh logic
- No state management library — screens subscribe directly to database streams

## Project structure

```
lib/
  data/
    database.dart       # tables: Trackers, TrackerEntries
    daos/                # one DAO per table
  features/
    dashboard/
    tracker_form/
    tracker_detail/
    stats/
    quick_tick/
  logic/
    streak_calculator.dart   # pure functions, no Flutter or DB imports
```

Dates are stored as plain `YYYY-MM-DD` strings rather than timestamps, since habits are day-granular and this avoids timezone issues entirely. A tracker can only have one entry per day, enforced by a unique constraint at the database level rather than in app code. Deleting a tracker archives it instead of removing it, so history isn't lost by accident.

## Running it

```bash
git clone https://github.com/TheIlkinAlizade/flutter-habit-tracker.git
cd flutter_habit_tracker
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

Requires the Flutter SDK.

## License

MIT — free to use, modify, or copy.