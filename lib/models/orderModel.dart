import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String? documentId;
  final int? totalPrice;
  final String? address;
  final String? quantitiy;

  OrderModel({
    this.totalPrice,
    this.address,
    this.documentId,
    this.quantitiy,
  });

  // Convert Order object to a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      //  "documentId": documentId,
      'totalPrice': totalPrice,
      'address': address,

      'quantitiy': quantitiy
    };
  }

  // Create an Order object from a Firestore DocumentSnapshot
  factory OrderModel.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    var data = snapshot.data();
    return OrderModel(
      documentId: snapshot.id,
      quantitiy: data['quantitiy'],
      totalPrice: data['totalPrice'],
      address: data['address'],
    );
  }
}
