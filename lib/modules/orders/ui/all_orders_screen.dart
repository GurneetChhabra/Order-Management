import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_care/models/order.dart';
import 'package:device_care/core/repository/order/repository.dart';
import 'package:flutter/material.dart';

import 'order_details_screen.dart';

class AllOrdersScreen extends StatefulWidget {
  const AllOrdersScreen({super.key});

  @override
  State<AllOrdersScreen> createState() => _AllOrdersScreenState();
}

class _AllOrdersScreenState extends State<AllOrdersScreen> {
  OrderRepository orderRepository = OrderRepository();
  String selectedStatus = "All";
  String searchText = "";
  List<OrderModel> orders = [];
  bool loading = false;

  loadData() async {
    loading = true;
    setState(() {});
    orders = await orderRepository.getFilteredOrders("All");
    loading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    final orderList = orders.where((order) {
      final matchesStatus =
          selectedStatus == "All" ? true : order.status == selectedStatus;

      final matchesSearch =
          order.customerName.toLowerCase().contains(searchText.toLowerCase());

      return matchesStatus && matchesSearch;
    }).toList();

    return Scaffold(
        backgroundColor: const Color(0xFFF5F8FF),
        appBar: AppBar(
          backgroundColor: const Color(0xFF0D4CFF),
          title: const Text(
            "All Orders",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                  hintText: "Search Customer",
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                  });
                },
              ),
              const SizedBox(height: 15),
              DropdownButtonFormField<String>(
                value: selectedStatus,
                items: const [
                  DropdownMenuItem(
                    value: "All",
                    child: Text("All"),
                  ),
                  DropdownMenuItem(
                    value: "Received",
                    child: Text("Received"),
                  ),
                  DropdownMenuItem(
                    value: "Repairing",
                    child: Text("Repairing"),
                  ),
                  DropdownMenuItem(
                    value: "Ready for Pickup",
                    child: Text("Ready for Pickup"),
                  ),
                  DropdownMenuItem(
                    value: "Delivered",
                    child: Text("Delivered"),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedStatus = value!;
                  });
                },
              ),
              const SizedBox(height: 15),
              Expanded(
                child: ListView.builder(
                  itemCount: orderList.length,
                  itemBuilder: (context, index) {
                    final order = orderList[index];

                    return Card(
                      child: ListTile(
                        title: Text(
                          order.customerName ?? '',
                        ),
                        subtitle: Text(
                          order.deviceModel ?? '',
                        ),
                        trailing: Text(
                          order.status ?? '',
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => OrderDetailsScreen(
                                orderId: order.orderId.toString(),
                                orderData: order.toMap(),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
