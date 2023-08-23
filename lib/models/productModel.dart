import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String? pName;
  final String? pPrice;
  final String? pImage;
  final String? pDescription;
  final String? pCategory;
  final String? pId;
  // final int? pQuantity;

  Product({
    //  this.pQuantity,
    this.pId,
    this.pName,
    this.pCategory,
    this.pDescription,
    this.pImage,
    this.pPrice,
  });

  // Convert Product object to a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'pName': pName,
      'pPrice': pPrice,
      'pImage': pImage,
      'pDescription': pDescription,
      'pCategory': pCategory,
      'pId': pId,
      //  'pQuantity': pQuantity,
    };
  }

  // Create a Product object from a Firestore DocumentSnapshot
  factory Product.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    var data = snapshot.data();
    return Product(
      pName: data['pName'],
      pPrice: data['pPrice'],
      pImage: data['pImage'],
      pDescription: data['pDescription'],
      pCategory: data['pCategory'],
      pId: data['pId'],
      //  pQuantity: data['pQuantity'],
    );
  }
}
