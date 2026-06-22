import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_care/core/provider/order_provider.dart';
import 'package:device_care/core/repository/order/repository.dart';
import 'package:device_care/models/order.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddEditOrderScreen extends StatefulWidget {
  final String? orderId;
  final Map<String, dynamic>? orderData;

  const AddEditOrderScreen({
    super.key,
    this.orderId,
    this.orderData,
  });

  @override
  State<AddEditOrderScreen> createState() =>
      _AddEditOrderScreenState();
}

class _AddEditOrderScreenState
    extends State<AddEditOrderScreen> {
      OrderRepository orderRepository = OrderRepository();
  final _formKey = GlobalKey<FormState>();

  final customerController =
      TextEditingController();

  final phoneController =
      TextEditingController();

  final brandController =
      TextEditingController();

  final modelController =
      TextEditingController();

  final issueController =
      TextEditingController();

  final costController =
      TextEditingController();

  final technicianController =
      TextEditingController();

  String status = "Received";

  bool loading = false;

  @override
  void initState() {
    super.initState();

    if (widget.orderData != null) {
      customerController.text =
          widget.orderData!['customerName'] ?? '';

      phoneController.text =
          widget.orderData!['phoneNumber'] ?? '';

      brandController.text =
          widget.orderData!['deviceBrand'] ?? '';

      modelController.text =
          widget.orderData!['deviceModel'] ?? '';

      issueController.text =
          widget.orderData!['issue'] ?? '';

      costController.text =
          widget.orderData!['estimatedCost']
                  ?.toString() ??
              '';

      technicianController.text =
          widget.orderData![
                  'assignedTechnician'] ??
              '';

      status =
          widget.orderData!['status'] ??
              "Received";
    }
  }

  @override
  void dispose() {
    customerController.dispose();
    phoneController.dispose();
    brandController.dispose();
    modelController.dispose();
    issueController.dispose();
    costController.dispose();
    technicianController.dispose();
    super.dispose();
  }

  InputDecoration inputDecoration(
      String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(14),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(14),
        borderSide: BorderSide(
          color: Colors.grey.shade300,
        ),
      ),
    );
  }

  Future<void> saveOrder() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      setState(() {
        loading = true;
      });

      final data = {
        "customerName":
            customerController.text.trim(),

        "phoneNumber":
            phoneController.text.trim(),

        "deviceBrand":
            brandController.text.trim(),

        "deviceModel":
            modelController.text.trim(),

        "issue":
            issueController.text.trim(),

        "estimatedCost":
            double.tryParse(
                  costController.text.trim(),
                ) ??
                0,

        "assignedTechnician":
            technicianController.text.trim(),

        "status": status,

        "updatedAt": Timestamp.now(),
      };

      final order = OrderModel(
  orderId: widget.orderId, // null for add, existing id for edit

  customerName:
      customerController.text.trim(),

  phoneNumber:
      phoneController.text.trim(),

  deviceBrand:
      brandController.text.trim(),

  deviceModel:
      modelController.text.trim(),

  issue:
      issueController.text.trim(),

  estimatedCost:
      double.tryParse(
        costController.text.trim(),
      ) ??
      0,

  assignedTechnician:
      technicianController.text.trim(),

  status: status,

  updatedAt: Timestamp.now(),
);

      if (widget.orderId == null) {
      String? result = await  orderRepository.addOrder(data);
        if(result != null){
       Provider.of<OrderProvider>(context, listen: false).setOrders(order);
        ScaffoldMessenger.of(context)
            .showSnackBar(
          const SnackBar(
            content:
                Text("Order Created"),
          ),
        );
        }

      } else {
        try{
       await  orderRepository.updateOrder(widget.orderId.toString(),data);
           Provider.of<OrderProvider>(context, listen: false).updateStatus(order);
        } catch(e){
          print(e);
        }
        

        ScaffoldMessenger.of(context)
            .showSnackBar(
          const SnackBar(
            content:
                Text("Order Updated"),
          ),
        );
      }

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }

    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> deleteOrder() async {
    final shouldDelete =
        await showDialog<bool>(
              context: context,
              builder: (_) => AlertDialog(
                title:
                    const Text("Delete Order"),
                content: const Text(
                  "Are you sure you want to delete this order?",
                ),
                actions: [
                  TextButton(
                    onPressed: () =>
                        Navigator.pop(
                            context, false),
                    child:
                        const Text("Cancel"),
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        Navigator.pop(
                            context, true),
                    child:
                        const Text("Delete"),
                  ),
                ],
              ),
            ) ??
            false;

    if (!shouldDelete) return;

    await FirebaseFirestore.instance
        .collection("orders")
        .doc(widget.orderId)
        .delete();

    if (mounted) {
      Navigator.pop(context);

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content:
              Text("Order Deleted"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit =
        widget.orderId != null;

    return Scaffold(
      backgroundColor:
          const Color(0xFFF5F8FF),

      appBar: AppBar(
        backgroundColor:
            const Color(0xFF0D4CFF),

        title: Text(
          isEdit
              ? "Edit Order"
              : "Add Order",
          style: const TextStyle(
            color: Colors.white,
          ),
        ),

        actions: [
          if (isEdit)
            IconButton(
              onPressed: deleteOrder,
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
        ],
      ),

      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller:
                    customerController,
                decoration:
                    inputDecoration(
                  "Customer Name",
                ),
                validator: (value) =>
                    value!.isEmpty
                        ? "Required"
                        : null,
              ),

              const SizedBox(
                  height: 16),

              TextFormField(
                controller:
                    phoneController,
                keyboardType:
                    TextInputType.phone,
                decoration:
                    inputDecoration(
                  "Phone Number",
                ),
                validator: (value) =>
                    value!.isEmpty
                        ? "Required"
                        : null,
              ),

              const SizedBox(
                  height: 16),

              TextFormField(
                controller:
                    brandController,
                decoration:
                    inputDecoration(
                  "Device Brand",
                ),
                validator: (value) =>
                    value!.isEmpty
                        ? "Required"
                        : null,
              ),

              const SizedBox(
                  height: 16),

              TextFormField(
                controller:
                    modelController,
                decoration:
                    inputDecoration(
                  "Device Model",
                ),
                validator: (value) =>
                    value!.isEmpty
                        ? "Required"
                        : null,
              ),

              const SizedBox(
                  height: 16),

              TextFormField(
                controller:
                    issueController,
                maxLines: 3,
                decoration:
                    inputDecoration(
                  "Issue Description",
                ),
                validator: (value) =>
                    value!.isEmpty
                        ? "Required"
                        : null,
              ),

              const SizedBox(
                  height: 16),

              TextFormField(
                controller:
                    costController,
                keyboardType:
                    TextInputType.number,
                decoration:
                    inputDecoration(
                  "Estimated Cost",
                ),
              ),

              const SizedBox(
                  height: 16),

              TextFormField(
                controller:
                    technicianController,
                decoration:
                    inputDecoration(
                  "Assigned Technician",
                ),
              ),

              const SizedBox(
                  height: 16),

              DropdownButtonFormField<
                  String>(
                value: status,
                decoration:
                    inputDecoration(
                  "Status",
                ),
                items: const [
                  DropdownMenuItem(
                    value: "Received",
                    child:
                        Text("Received"),
                  ),
                  DropdownMenuItem(
                    value: "Repairing",
                    child:
                        Text("Repairing"),
                  ),
                  DropdownMenuItem(
                    value:
                        "Ready for Pickup",
                    child: Text(
                        "Ready for Pickup"),
                  ),
                  DropdownMenuItem(
                    value: "Delivered",
                    child:
                        Text("Delivered"),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    status = value!;
                  });
                },
              ),

              const SizedBox(
                  height: 30),

              SizedBox(
                width:
                    double.infinity,
                height: 55,
                child:
                    ElevatedButton(
                  style:
                      ElevatedButton
                          .styleFrom(
                    backgroundColor:
                        const Color(
                            0xFF0D4CFF),
                  ),
                  onPressed: loading
                      ? null
                      : saveOrder,
                  child: loading
                      ? const CircularProgressIndicator(
                          color: Colors
                              .white,
                        )
                      : Text(
                          isEdit
                              ? "UPDATE ORDER"
                              : "CREATE ORDER",
                          style:
                              const TextStyle(
                            color: Colors
                                .white,
                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}