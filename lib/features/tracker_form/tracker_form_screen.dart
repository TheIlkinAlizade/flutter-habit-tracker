import 'package:flutter/material.dart';
import '../../data/app_database_provider.dart';
import '../../data/icon_map.dart';

class TrackerFormScreen extends StatefulWidget {
  const TrackerFormScreen({super.key});

  @override
  State<TrackerFormScreen> createState() => _TrackerFormScreenState();
}

class _TrackerFormScreenState extends State<TrackerFormScreen> {
  final _nameController = TextEditingController();
  int _selectedColor = 0xFF4C8DFF;
  String _selectedIcon = 'check';
  String _scheduleType = 'daily';
  final Set<int> _selectedWeekdays = {};
  int _monthlyDay = 1;

  static const _colorOptions = [
    0xFF4C8DFF,
    0xFFFF5A5F,
    0xFFB94CFF,
    0xFF37D67A,
    0xFFFFB020,
  ];
  
  static const _weekdayLabels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  String? _buildScheduleConfig() {
    switch (_scheduleType) {
      case 'weekly_days':
        if (_selectedWeekdays.isEmpty) return null;
        final sorted = _selectedWeekdays.toList()..sort();
        return sorted.join(',');
      case 'monthly':
        return '$_monthlyDay';
      default:
        return null;
    }
  }

  Future<void> _save() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    if (_scheduleType == 'weekly_days' && _selectedWeekdays.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pick at least one day of the week')),
      );
      return;
    }

    await database.trackerDao.createTracker(
      name: name,
      color: _selectedColor,
      icon: _selectedIcon,
      scheduleType: _scheduleType,
      scheduleConfig: _buildScheduleConfig(),
    );
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Tracker')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              autofocus: true,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Tracker name',
                hintText: 'e.g. IELTS Study',
              ),
            ),
            const SizedBox(height: 24),
            const Text('Color', style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 12,
              children: _colorOptions.map((c) {
                final selected = c == _selectedColor;
                return GestureDetector(
                  onTap: () => setState(() => _selectedColor = c),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(c),
                      shape: BoxShape.circle,
                      border: selected
                          ? Border.all(color: Colors.white, width: 3)
                          : null,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            const Text('Icon', style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: trackerIconOptions.entries.map((entry) {
                final selected = entry.key == _selectedIcon;
                return GestureDetector(
                  onTap: () => setState(() => _selectedIcon = entry.key),
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: selected
                          ? Color(_selectedColor).withValues(alpha: 0.2)
                          : Colors.white.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(10),
                      border: selected
                          ? Border.all(color: Color(_selectedColor), width: 2)
                          : null,
                    ),
                    child: Icon(
                      entry.value,
                      color: selected ? Color(_selectedColor) : Colors.white54,
                      size: 20,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            const Text('Repeat', style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 10),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'daily', label: Text('Daily')),
                ButtonSegment(value: 'weekly_days', label: Text('Weekly')),
                ButtonSegment(value: 'monthly', label: Text('Monthly')),
              ],
              selected: {_scheduleType},
              onSelectionChanged: (selection) {
                setState(() => _scheduleType = selection.first);
              },
            ),
            if (_scheduleType == 'weekly_days') ...[
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                children: List.generate(7, (i) {
                  final weekday = i + 1;
                  final selected = _selectedWeekdays.contains(weekday);
                  return GestureDetector(
                    onTap: () => setState(() {
                      selected
                          ? _selectedWeekdays.remove(weekday)
                          : _selectedWeekdays.add(weekday);
                    }),
                    child: Container(
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: selected
                            ? Color(_selectedColor)
                            : Colors.white.withValues(alpha: 0.06),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        _weekdayLabels[i],
                        style: TextStyle(
                          color: selected ? Colors.black : Colors.white54,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
            if (_scheduleType == 'monthly') ...[
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('Day of month:', style: TextStyle(color: Colors.white70)),
                  const SizedBox(width: 12),
                  DropdownButton<int>(
                    value: _monthlyDay,
                    dropdownColor: const Color(0xFF1A1A1D),
                    style: const TextStyle(color: Colors.white),
                    items: List.generate(28, (i) => i + 1)
                        .map((d) => DropdownMenuItem(value: d, child: Text('$d')))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => _monthlyDay = val);
                    },
                  ),
                ],
              ),
            ],
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _save,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text('Create'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}