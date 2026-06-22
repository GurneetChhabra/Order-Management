import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String? orderId;

  final String customerName;
  final String phoneNumber;

  final String deviceBrand;
  final String deviceModel;

  final String issue;

  final double estimatedCost;

  final String assignedTechnician;

  final String status;

  final Timestamp? createdAt;
  final Timestamp? updatedAt;

  OrderModel({
    this.orderId,
    required this.customerName,
    required this.phoneNumber,
    required this.deviceBrand,
    required this.deviceModel,
    required this.issue,
    required this.estimatedCost,
    required this.assignedTechnician,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory OrderModel.fromMap(
    Map<String, dynamic> map, {
    String? documentId,
  }) {
    return OrderModel(
      orderId: documentId ?? map['orderId'],

      customerName: map['customerName'] ?? '',

      phoneNumber: map['phoneNumber'] ?? '',

      deviceBrand: map['deviceBrand'] ?? '',

      deviceModel: map['deviceModel'] ?? '',

      issue: map['issue'] ?? '',

      estimatedCost:
          (map['estimatedCost'] ?? 0).toDouble(),

      assignedTechnician:
          map['assignedTechnician'] ?? '',

      status: map['status'] ?? 'Received',

      createdAt: map['createdAt'],

      updatedAt: map['updatedAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "orderId": orderId,
      "customerName": customerName,
      "phoneNumber": phoneNumber,
      "deviceBrand": deviceBrand,
      "deviceModel": deviceModel,
      "issue": issue,
      "estimatedCost": estimatedCost,
      "assignedTechnician": assignedTechnician,
      "status": status,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
    };
  }
}