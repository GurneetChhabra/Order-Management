import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_care/models/order.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class OrderRepository {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<OrderModel>> getFilteredOrders(String status) async {
    final ordersRef = db.collection("orders");
    QuerySnapshot snapshot;

    if (status == "All") {
      snapshot = await ordersRef.get();
    } else {
      snapshot = await ordersRef.where("status", isEqualTo: status).get();
    }

    return snapshot.docs.map((doc) {
      return OrderModel.fromMap(
        doc.data() as Map<String, dynamic>,
        documentId: doc.id,
      );
    }).toList();
  }

  Future<String?> addOrder(
    Map<String, dynamic> data,
  ) async {
    try{
    final docRef = await db.collection("orders").add({
      ...data,
      "createdAt": Timestamp.now(),
    });

    return docRef.id;
    } catch(e){
      print(e);
      return null;
    }
  }

  Future<void> updateOrder(
  String orderId,
  Map<String, dynamic> data,
) async {
  await db
      .collection("orders")
      .doc(orderId)
      .update({
    ...data,
    "updatedAt": Timestamp.now(),
  });
}
}
