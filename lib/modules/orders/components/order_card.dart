import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  final String orderId;
  final String customer;
  final String device;
  final String issue;
  final String status;

  const OrderCard({
    super.key,
    required this.orderId,
    required this.customer,
    required this.device,
    required this.issue,
    required this.status,
  });

  Color getStatusColor() {
    switch (status) {
      case "Delivered":
        return Colors.green;

      case "Repairing":
        return Colors.orange;

      case "Received":
        return Colors.blue;

      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Card(
      margin: const EdgeInsets.only(bottom: 12),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),

      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Color(0xFF0D4CFF),
          child: Icon(
            Icons.phone_android,
            color: Colors.white,
          ),
        ),

        title: Text(customer),

        subtitle: Text(
          "$device\n$issue",
        ),

        trailing: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            color: getStatusColor().withOpacity(.15),
            borderRadius:
            BorderRadius.circular(20),
          ),
          child: Text(
            status,
            style: TextStyle(
              color: getStatusColor(),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}