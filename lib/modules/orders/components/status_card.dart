import 'package:flutter/material.dart';

class StatusCard extends StatelessWidget
 {
  final String title;
  final int count;
  final IconData icon;

  const StatusCard({
    super.key,
    required this.title,
    required this.count,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.grey.shade200,
          )
        ],
      ),

      child: Column(
        children: [
          Icon(
            icon,
            color: const Color(0xFF0D4CFF),
          ),

          const SizedBox(height: 8),

          Text(
            count.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),

          Text(title),
        ],
      ),
    );
  }
}