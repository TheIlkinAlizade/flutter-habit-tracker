import 'package:shared_preferences/shared_preferences.dart';
import '../features/dashboard/heatmap_strip.dart';

class HeatmapRangePrefs {
  static String _key(int trackerId) => 'heatmap_range_$trackerId';

  static Future<HeatmapRange> load(int trackerId) async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString(_key(trackerId));
    return HeatmapRange.values.firstWhere(
      (r) => r.name == stored,
      orElse: () => HeatmapRange.year,
    );
  }

  static Future<void> save(int trackerId, HeatmapRange range) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key(trackerId), range.name);
  }
}