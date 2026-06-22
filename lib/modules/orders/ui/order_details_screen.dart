import 'package:device_care/modules/orders/ui/add_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderDetailsScreen extends StatelessWidget {
  final String orderId;
  final Map<String, dynamic> orderData;

  const OrderDetailsScreen({
    super.key,
    required this.orderId,
    required this.orderData,
  });

  @override
  Widget build(BuildContext context) {
    final Timestamp? createdAt =
        orderData['createdAt'];

    final Timestamp? updatedAt =
        orderData['updatedAt'];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FF),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0D4CFF),
        title: const Text(
          "Order Details",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF0D4CFF),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddEditOrderScreen(
                orderId: orderId,
                orderData: orderData,
              ),
            ),
          );
        },
        label: const Text(
          "Edit",
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            _sectionCard(
              title: "Customer Information",
              children: [
                _infoTile(
                  Icons.person,
                  "Customer Name",
                  orderData['customerName'] ?? '-',
                ),
                _infoTile(
                  Icons.phone,
                  "Phone Number",
                  orderData['phoneNumber'] ?? '-',
                ),
              ],
            ),

            const SizedBox(height: 16),

            _sectionCard(
              title: "Device Information",
              children: [
                _infoTile(
                  Icons.devices,
                  "Device Brand",
                  orderData['deviceBrand'] ?? '-',
                ),
                _infoTile(
                  Icons.phone_android,
                  "Device Model",
                  orderData['deviceModel'] ?? '-',
                ),
                _infoTile(
                  Icons.report_problem_outlined,
                  "Issue",
                  orderData['issue'] ?? '-',
                ),
              ],
            ),

            const SizedBox(height: 16),

            _sectionCard(
              title: "Repair Information",
              children: [
                _infoTile(
                  Icons.build,
                  "Technician",
                  orderData['assignedTechnician'] ?? '-',
                ),
                _infoTile(
                  Icons.currency_rupee,
                  "Estimated Cost",
                  "₹${orderData['estimatedCost'] ?? 0}",
                ),
                _statusTile(
                  orderData['status'] ?? 'Received',
                ),
              ],
            ),

            const SizedBox(height: 16),

            _sectionCard(
              title: "Order Metadata",
              children: [
                _infoTile(
                  Icons.tag,
                  "Order ID",
                  orderId,
                ),
                _infoTile(
                  Icons.calendar_month,
                  "Created",
                  createdAt == null
                      ? "-"
                      : createdAt
                          .toDate()
                          .toString(),
                ),
                _infoTile(
                  Icons.update,
                  "Updated",
                  updatedAt == null
                      ? "-"
                      : updatedAt
                          .toDate()
                          .toString(),
                ),
              ],
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _sectionCard({
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const Divider(height: 25),

            ...children,
          ],
        ),
      ),
    );
  }

  Widget _infoTile(
    IconData icon,
    String label,
    String value,
  ) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color:
                const Color(0xFF0D4CFF),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  value,
                  style:
                      const TextStyle(
                    fontSize: 16,
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusTile(String status) {
    Color color;

    switch (status) {
      case "Delivered":
        color = Colors.green;
        break;

      case "Repairing":
        color = Colors.orange;
        break;

      case "Ready for Pickup":
        color = Colors.blue;
        break;

      default:
        color = Colors.grey;
    }

    return Row(
      children: [
        const Icon(
          Icons.circle,
          size: 14,
        ),

        const SizedBox(width: 12),

        const Text(
          "Status",
          style: TextStyle(
            color: Colors.grey,
          ),
        ),

        const Spacer(),

        Container(
          padding:
              const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color:
                color.withOpacity(.15),
            borderRadius:
                BorderRadius.circular(
                    20),
          ),
          child: Text(
            status,
            style: TextStyle(
              color: color,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}