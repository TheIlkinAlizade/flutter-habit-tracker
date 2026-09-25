import 'package:flutter/material.dart';

class HeatmapStrip extends StatelessWidget {
  final Set<String> doneDates;
  final Color color;
  final DateTime createdAt;
  final int columns;
  final double height;

  const HeatmapStrip({
    super.key,
    required this.doneDates,
    required this.color,
    required this.createdAt,
    required this.columns,
    this.height = 44,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return CustomPaint(
          size: Size(constraints.maxWidth, height),
          painter: _HeatmapPainter(
            doneDates: doneDates,
            color: color,
            createdAt: createdAt,
            columns: columns,
          ),
        );
      },
    );
  }
}

class _HeatmapPainter extends CustomPainter {
  final Set<String> doneDates;
  final Color color;
  final DateTime createdAt;
  final int columns;

  _HeatmapPainter({
    required this.doneDates,
    required this.color,
    required this.createdAt,
    required this.columns,
  });

  String _dateStr(DateTime d) {
    return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
  }

  @override
  void paint(Canvas canvas, Size size) {
    const spacing = 3.0;
    const rows = 7;

    if (columns <= 0) return;

    final cellSize = (size.width - (columns - 1) * spacing) / columns;

    final today = DateTime.now();
    final todayNormalized = DateTime(today.year, today.month, today.day);
    final createdAtNormalized = DateTime(createdAt.year, createdAt.month, createdAt.day);

    final totalDays = columns * rows;
    final startDate = todayNormalized.subtract(Duration(days: totalDays - 1));
    final gridStartOffset = (startDate.weekday - 1) % 7;

    final paint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < totalDays; i++) {
      final date = startDate.add(Duration(days: i));
      if (date.isAfter(todayNormalized)) break;

      final cellIndex = i + gridStartOffset;
      final col = cellIndex ~/ rows;
      final row = cellIndex % rows;

      final dx = col * (cellSize + spacing);
      final dy = row * (cellSize + spacing);

      final isDone = doneDates.contains(_dateStr(date));
      final beforeCreation = date.isBefore(createdAtNormalized);

      paint.color = isDone
          ? color
          : Colors.white.withValues(alpha: beforeCreation ? 0.03 : 0.06);

      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(dx, dy, cellSize, cellSize),
        Radius.circular(cellSize * 0.25),
      );
      canvas.drawRRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _HeatmapPainter oldDelegate) {
    return oldDelegate.doneDates != doneDates ||
        oldDelegate.color != color ||
        oldDelegate.createdAt != createdAt ||
        oldDelegate.columns != columns;
  }
}