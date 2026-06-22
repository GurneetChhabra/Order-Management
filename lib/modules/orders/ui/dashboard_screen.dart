import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_care/modules/orders/ui/add_order_screen.dart';
import 'package:device_care/modules/orders/ui/all_orders_screen.dart';
import 'package:device_care/core/provider/order_provider.dart';
import 'package:device_care/modules/orders/ui/filtered_orders_screen.dart';
import 'package:device_care/models/order.dart';
import 'package:device_care/modules/orders/components/order_card.dart';
import 'package:device_care/modules/orders/ui/order_details_screen.dart';
import 'package:device_care/modules/orders/profile/profile_screen.dart';
import 'package:device_care/core/repository/order/repository.dart';
import 'package:device_care/modules/orders/components/status_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  OrderRepository orderRepository = OrderRepository();
  String selectedStatus = "All";
  List filteredDocs = [];
  int received = 0;
  int repairing = 0;
  int ready = 0;
  int delivered = 0;

  List<OrderModel> orders = [];
  bool loading = false;

  loadData() async {
    loading = true;
    setState(() {});
    orders = await orderRepository.getFilteredOrders("All");
    Provider.of<OrderProvider>(context, listen: false).setAllOrders(orders);
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
        elevation: 0,
        backgroundColor: const Color(0xFF0D4CFF),
        title: const Text(
          "DeviceCare",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProfileScreen(),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF0D4CFF),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          // Add Order Screen
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddEditOrderScreen()));
        },
      ),
      body: Consumer<OrderProvider>(builder: (context, state, child) {
        if(state.orders.isNotEmpty){
        received = state.orders.where((e) => e.status == "Received").length;

        repairing = state.orders.where((e) => e.status == "Repairing").length;

        ready = state.orders.where((e) => e.status == "Ready for Pickup").length;

        delivered = state.orders.where((e) => e.status == "Delivered").length;
        } 
        // else{
        // received = orders.where((e) => e.status == "Received").length;

        // repairing = orders.where((e) => e.status == "Repairing").length;

        // ready = orders.where((e) => e.status == "Ready for Pickup").length;

        // delivered = orders.where((e) => e.status == "Delivered").length;
        // }
        return SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color(0xFF0D4CFF),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome Back 👋",
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Device Manager",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: ListView(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              FilteredOrdersScreen(
                                                  filter: "Received")));
                                },
                                child: StatusCard(
                                  title: "Received",
                                  count: received,
                                  icon: Icons.inventory,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              FilteredOrdersScreen(
                                                  filter: "Repairing")));
                                },
                                child: StatusCard(
                                  title: "Repairing",
                                  count: repairing,
                                  icon: Icons.build,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              FilteredOrdersScreen(
                                                  filter: "Ready")));
                                },
                                child: StatusCard(
                                  title: "Ready",
                                  count: ready,
                                  icon: Icons.check_circle,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              FilteredOrdersScreen(
                                                  filter: "Delivered")));
                                },
                                child: StatusCard(
                                  title: "Delivered",
                                  count: delivered,
                                  icon: Icons.local_shipping,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          decoration: InputDecoration(
                            hintText: "Search Orders",
                            prefixIcon: const Icon(Icons.search),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Recent Orders",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const AllOrdersScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                "View All",
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.orders.length,
                          itemBuilder: (_, index) {
                            final order = state.orders[index];

                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            OrderDetailsScreen(
                                              orderId: order.orderId.toString(),
                                              orderData: order.toMap(),
                                            )));
                              },
                              child: OrderCard(
                                orderId: order.orderId.toString(),
                                customer: order.customerName,
                                device: order.deviceModel,
                                issue: order.issue,
                                status: order.status,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  if (loading)
                    Center(
                      child: CircularProgressIndicator(),
                    )
                ],
              ))
            ],
          ),
        );
      }),
    );
  }
}
