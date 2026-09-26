import 'package:flutter/material.dart';

enum HeatmapRange { week, month, year }

class HeatmapStrip extends StatelessWidget {
  final Set<String> doneDates;
  final Color color;
  final DateTime createdAt;
  final HeatmapRange range;
  final double height;

  const HeatmapStrip({
    super.key,
    required this.doneDates,
    required this.color,
    required this.createdAt,
    required this.range,
    this.height = 44,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return CustomPaint(
              painter: _HeatmapPainter(
                doneDates: doneDates,
                color: color,
                createdAt: createdAt,
                range: range,
                availableWidth: constraints.maxWidth,
                availableHeight: height,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _HeatmapPainter extends CustomPainter {
  final Set<String> doneDates;
  final Color color;
  final DateTime createdAt;
  final HeatmapRange range;
  final double availableWidth;
  final double availableHeight;

  _HeatmapPainter({
    required this.doneDates,
    required this.color,
    required this.createdAt,
    required this.range,
    required this.availableWidth,
    required this.availableHeight,
  });

  String _dateStr(DateTime d) {
    return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
  }

  @override
  void paint(Canvas canvas, Size size) {
    const spacing = 3.0;
    final today = DateTime.now();
    final todayNormalized = DateTime(today.year, today.month, today.day);
    final createdAtNormalized = DateTime(createdAt.year, createdAt.month, createdAt.day);
    final paint = Paint()..style = PaintingStyle.fill;

    if (range == HeatmapRange.year) {
      const rows = 7;
      final cellSize = (availableHeight - (rows - 1) * spacing) / rows;
      final columns = ((availableWidth + spacing) / (cellSize + spacing))
          .floor()
          .clamp(1, 53);
      final totalDays = columns * rows;
      final startDate = todayNormalized.subtract(Duration(days: totalDays - 1));

      for (int i = 0; i < totalDays; i++) {
        final date = startDate.add(Duration(days: i));
        if (date.isAfter(todayNormalized)) break;
        final col = i ~/ rows;
        final row = i % rows;
        _drawCell(canvas, paint, date, col * (cellSize + spacing),
            row * (cellSize + spacing), cellSize, doneDates, color, createdAtNormalized);
      }
      return;
    }

    late DateTime gridStart;
    late int leadingBlanks;
    late int numRows;

    if (range == HeatmapRange.week) {
      gridStart = todayNormalized.subtract(Duration(days: todayNormalized.weekday - 1));
      leadingBlanks = 0;
      numRows = 1;
    } else {
      final firstOfMonth = DateTime(today.year, today.month, 1);
      leadingBlanks = (firstOfMonth.weekday - 1) % 7;
      final daysInMonth = DateTime(today.year, today.month + 1, 0).day;
      numRows = ((leadingBlanks + daysInMonth) / 7).ceil();
      gridStart = firstOfMonth.subtract(Duration(days: leadingBlanks));
    }

    const cols = 7;
    final cellHeight = (availableHeight - (numRows - 1) * spacing) / numRows;
    final cellWidth = (availableWidth - (cols - 1) * spacing) / cols;
    final cellSize = cellHeight < cellWidth ? cellHeight : cellWidth;

    final totalCells = numRows * cols;

    for (int i = 0; i < totalCells; i++) {
      if (range == HeatmapRange.month && i < leadingBlanks) continue;

      final date = gridStart.add(Duration(days: i));
      if (date.isAfter(todayNormalized)) break;

      final row = i ~/ cols;
      final col = i % cols;

      _drawCell(canvas, paint, date, col * (cellSize + spacing),
          row * (cellSize + spacing), cellSize, doneDates, color, createdAtNormalized);
    }
  }

  void _drawCell(
    Canvas canvas,
    Paint paint,
    DateTime date,
    double dx,
    double dy,
    double cellSize,
    Set<String> doneDates,
    Color color,
    DateTime createdAtNormalized,
  ) {
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

  @override
  bool shouldRepaint(covariant _HeatmapPainter oldDelegate) {
    return oldDelegate.doneDates != doneDates ||
        oldDelegate.color != color ||
        oldDelegate.createdAt != createdAt ||
        oldDelegate.range != range ||
        oldDelegate.availableWidth != availableWidth;
  }
}