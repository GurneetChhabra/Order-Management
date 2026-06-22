import 'package:device_care/models/order.dart';
import 'package:flutter/material.dart';

class OrderProvider extends ChangeNotifier{
  int receivedCount = 0;
int repairingCount = 0;
int readyCount = 0;
int deliveredCount = 0;
List<OrderModel> orders = [];
Future<void> addStatus(
  String status,
) async {
  // await repository.addOrder(
  //   order.toMap(),
  // );

  switch (status) {
    case "Received":
      receivedCount++;
      break;

    case "Repairing":
      repairingCount++;
      break;

    case "Ready for Pickup":
      readyCount++;
      break;

    case "Delivered":
      deliveredCount++;
      break;
  }

  notifyListeners();
}

Future<void> updateStatus(
 OrderModel order
) async {

    orders.removeWhere((e)=> e.orderId== order.orderId);
    orders.add(order);

  notifyListeners();
}

 setOrders(OrderModel order){
  orders.add(order);
  notifyListeners();
 }

  setAllOrders(List<OrderModel> orderList){
  orders.addAll(orderList);
  notifyListeners();
 }
 reset(){
  orders = [];
 }
}