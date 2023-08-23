import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_flutter/common/constant.dart';
import 'package:ecommerce_flutter/common/snakbar.dart';
import 'package:ecommerce_flutter/functions.dart';
import 'package:ecommerce_flutter/models/orderModel.dart';
import 'package:ecommerce_flutter/models/productModel.dart';
import 'package:ecommerce_flutter/screens/admin/adminHome.dart';
import 'package:flutter/material.dart';

class Store {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> saveUserDataToFirebase({
    required File? imageFile,
    required String category,
    required String price,
    required String description,
    required String name,
    required BuildContext context,
  }) async {
    Product? product;
    try {
      String photoUrl =
          'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png';
      String rand =
          "${DateTime.now().microsecondsSinceEpoch + Random().nextInt(1000)}";
      if (imageFile != null) {
        // var imageName = basename(imageFile.path);
        photoUrl = await storeFileToFirebase(imageFile, "${rand}");
      }

      product = Product(
          pId: "$rand",
          pImage: photoUrl,
          pCategory: category,
          pDescription: description,
          pName: name,
          pPrice: price);

      await _firestore
          .collection(kProductsCollection)
          .doc(product.pId)
          .set(product.toMap());

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => AdminHome(),
        ),
        (route) => false,
      );
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  Future<void> editProduct(Product product, BuildContext context) async {
    // _firestore.collection(kProductsCollection).add({
    //   kProductName: product.pName,
    //   kProductDescription: product.pDescription,
    //   kProductLocation: product.pLocation,
    //   kProductCategory: product.pCategory,
    //   kProductPrice: product.pPrice
    // });
    try {
      await _firestore
          .collection(kProductsCollection)
          .doc(product.pId)
          .set(product.toMap());
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => AdminHome(),
        ),
        (route) => false,
      );
    } catch (e) {
      showSnackBar(context: context, content: "can\'t edit");
    }
  }

  Future<List<Product>> loadProducts() async {
    final response = await _firestore.collection(kProductsCollection).get();

    return response.docs.map((e) => Product.fromSnapshot(e)).toList();
  }

  Stream<List<OrderModel>> loadOrders() {
    return _firestore.collection(kOrders).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList();
    });
  }

  Stream<QuerySnapshot> loadOrderDetails(documentId) {
    return _firestore
        .collection(kOrders)
        .doc(documentId)
        .collection(kOrderDetails)
        .snapshots();
  }

  deleteProduct(documentId) {
    _firestore.collection(kProductsCollection).doc(documentId).delete();
  }

  // editProduct(data, documentId) {
  //   _firestore.collection(kProductsCollection).doc(documentId).update(data);
  // }

  Future<void> storeOrders(OrderModel orderModel) async {
    await _firestore.collection(kOrders).add(orderModel.toMap());

    //documentRef.set(data);
    // for (var product in products) {
    //   documentRef.collection(kOrderDetails).doc().set({
    //     kProductName: product.pName,
    //     kProductPrice: product.pPrice,
    //     //  kProductQuantity: product.pQuantity,
    //     //   kProductLocation: product.pLocation,
    //     kProductCategory: product.pCategory
    //   });
    // }
  }
}
