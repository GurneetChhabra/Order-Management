import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_care/models/order.dart';
import 'package:device_care/core/repository/order/repository.dart';
import 'package:flutter/material.dart';

import 'order_details_screen.dart';

class FilteredOrdersScreen extends StatefulWidget {
  final String filter;

  const FilteredOrdersScreen({super.key, required this.filter});

  @override
  State<FilteredOrdersScreen> createState() => _FilteredOrdersScreenState();
}

class _FilteredOrdersScreenState extends State<FilteredOrdersScreen> {
  OrderRepository orderRepository = OrderRepository();
  String selectedStatus = "All";
  String searchText = "";
  List<OrderModel> orders = [];
  bool loading = false;

  loadData() async {
    loading = true;
    setState(() {});
    orders = await orderRepository.getFilteredOrders(widget.filter);
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
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D4CFF),
        title: Text(
          "${widget.filter} Orders",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: 
         
      Stack(
        children: [
          Padding(
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
                    Expanded(
                      child: ListView.builder(
                        itemCount: orders.length,
                        itemBuilder: (context, index) {
                          final order = orders[index];
          
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
              ),
              if(loading)
              Center(
                child: CircularProgressIndicator(),
              )
        ],
      )
    );
  }
}
