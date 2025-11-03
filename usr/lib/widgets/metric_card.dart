import 'package:flutter/material.dart';

class MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String change;
  final bool? isUp;

  const MetricCard({
    super.key,
    required this.title,
    required this.value,
    required this.change,
    this.isUp,
  });

  @override
  Widget build(BuildContext context) {
    Color changeColor = isUp == null ? Colors.white70 : (isUp! ? Colors.greenAccent : Colors.redAccent);
    IconData? changeIcon = isUp == null ? null : (isUp! ? Icons.arrow_upward : Icons.arrow_downward);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                if (changeIcon != null)
                  Icon(changeIcon, color: changeColor, size: 16),
                if (changeIcon != null) const SizedBox(width: 4),
                Text(
                  change,
                  style: TextStyle(color: changeColor.withOpacity(0.8)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
