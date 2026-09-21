import 'package:flutter/material.dart';
import '../../data/app_database_provider.dart';

class TrackerFormScreen extends StatefulWidget {
  const TrackerFormScreen({super.key});

  @override
  State<TrackerFormScreen> createState() => _TrackerFormScreenState();
}

class _TrackerFormScreenState extends State<TrackerFormScreen> {
  final _nameController = TextEditingController();
  int _selectedColor = 0xFF4C8DFF;

  static const _colorOptions = [
    0xFF4C8DFF,
    0xFFFF5A5F,
    0xFFB94CFF,
    0xFF37D67A,
    0xFFFFB020,
  ];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;
    await database.trackerDao.createTracker(name: name, color: _selectedColor);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Tracker')),
      body: Padding(
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