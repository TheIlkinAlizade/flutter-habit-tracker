import 'package:flutter/material.dart';

enum HeatmapRange { week, month, year }

class HeatmapStrip extends StatelessWidget {
  final Set<String> doneDates;
  final Color color;
  final DateTime createdAt;
  final HeatmapRange range;

  const HeatmapStrip({
    super.key,
    required this.doneDates,
    required this.color,
    required this.createdAt,
    required this.range,
  });

  String _dateStr(DateTime d) {
    return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    if (range == HeatmapRange.year) {
      return _YearHeatmap(doneDates: doneDates, color: color, createdAt: createdAt);
    }

    final today = DateTime.now();
    final todayNormalized = DateTime(today.year, today.month, today.day);
    final createdAtNormalized = DateTime(createdAt.year, createdAt.month, createdAt.day);

    late DateTime gridStart;
    late int rows;
    late int leadingBlanks;

    if (range == HeatmapRange.week) {
      gridStart = todayNormalized.subtract(Duration(days: todayNormalized.weekday - 1));
      rows = 1;
      leadingBlanks = 0;
    } else {
      final firstOfMonth = DateTime(today.year, today.month, 1);
      leadingBlanks = (firstOfMonth.weekday - 1) % 7;
      final daysInMonth = DateTime(today.year, today.month + 1, 0).day;
      rows = ((leadingBlanks + daysInMonth) / 7).ceil();
      gridStart = firstOfMonth.subtract(Duration(days: leadingBlanks));
    }

    const spacing = 4.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        final cellSize = ((constraints.maxWidth - spacing * 6) / 7).clamp(0, 40).toDouble();

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(rows, (row) {
            return Padding(
              padding: EdgeInsets.only(bottom: row == rows - 1 ? 0 : spacing),
              child: Row(
                children: List.generate(7, (col) {
                  final index = row * 7 + col;

                  if (range == HeatmapRange.month && index < leadingBlanks) {
                    return Padding(
                      padding: EdgeInsets.only(right: col == 6 ? 0 : spacing),
                      child: SizedBox(width: cellSize, height: cellSize),
                    );
                  }

                  final date = gridStart.add(Duration(days: index));
                  final isDone = doneDates.contains(_dateStr(date));
                  final isFuture = date.isAfter(todayNormalized);
                  final isBeforeCreation = date.isBefore(createdAtNormalized);

                  Color fill;
                  Border? border;

                  if (isDone) {
                    fill = color;
                    border = null;
                  } else if (isFuture) {
                    fill = Colors.transparent;
                    border = Border.all(color: Colors.white.withValues(alpha: 0.15), width: 1);
                  } else if (isBeforeCreation) {
                    fill = Colors.white.withValues(alpha: 0.03);
                    border = null;
                  } else {
                    fill = Colors.white.withValues(alpha: 0.08);
                    border = null;
                  }

                  return Padding(
                    padding: EdgeInsets.only(right: col == 6 ? 0 : spacing),
                    child: Container(
                      width: cellSize,
                      height: cellSize,
                      decoration: BoxDecoration(
                        color: fill,
                        border: border,
                        borderRadius: BorderRadius.circular(cellSize * 0.25),
                      ),
                    ),
                  );
                }),
              ),
            );
          }),
        );
      },
    );
  }
}

class _YearHeatmap extends StatelessWidget {
  final Set<String> doneDates;
  final Color color;
  final DateTime createdAt;

  const _YearHeatmap({required this.doneDates, required this.color, required this.createdAt});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: SizedBox(
        height: 44,
        width: double.infinity,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return CustomPaint(
              painter: _YearPainter(
                doneDates: doneDates,
                color: color,
                createdAt: createdAt,
                availableWidth: constraints.maxWidth,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _YearPainter extends CustomPainter {
  final Set<String> doneDates;
  final Color color;
  final DateTime createdAt;
  final double availableWidth;

  _YearPainter({
    required this.doneDates,
    required this.color,
    required this.createdAt,
    required this.availableWidth,
  });

  String _dateStr(DateTime d) {
    return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
  }

  @override
  void paint(Canvas canvas, Size size) {
    const spacing = 3.0;
    const rows = 7;

    final cellSize = (size.height - (rows - 1) * spacing) / rows;
    final columns = ((availableWidth + spacing) / (cellSize + spacing)).floor().clamp(1, 53);
    final totalDays = columns * rows;

    final today = DateTime.now();
    final todayNormalized = DateTime(today.year, today.month, today.day);
    final createdAtNormalized = DateTime(createdAt.year, createdAt.month, createdAt.day);
    final startDate = todayNormalized.subtract(Duration(days: totalDays - 1));

    final paint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < totalDays; i++) {
      final date = startDate.add(Duration(days: i));
      if (date.isAfter(todayNormalized)) break;

      final col = i ~/ rows;
      final row = i % rows;
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
  bool shouldRepaint(covariant _YearPainter oldDelegate) {
    return oldDelegate.doneDates != doneDates ||
        oldDelegate.color != color ||
        oldDelegate.createdAt != createdAt ||
        oldDelegate.availableWidth != availableWidth;
  }
}