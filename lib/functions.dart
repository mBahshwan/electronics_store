import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_flutter/common/constant.dart';
import 'package:ecommerce_flutter/common/snakbar.dart';
import 'package:ecommerce_flutter/models/productModel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<List<Product>> getProductByCategory(String category) async {
  List<Product> products = [];
  try {
    // for (var product in allproducts) {
    //   if (product.pCategory == kJackets) {
    //     products.add(product);
    //   }
    // }
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot response =
        await firestore.collection(kProductsCollection).get();
    for (var element
        in response.docs as List<QueryDocumentSnapshot<Map<String, dynamic>>>) {
      var data = Product.fromSnapshot(element);
      products.add(data);
    }
  } on Error catch (ex) {
    print(ex);
  }
  return products.where((element) => element.pCategory == category).toList();
}

Future<File?> pickImageFromGallery(BuildContext context) async {
  File? image;
  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    showSnackBar(context: context, content: e.toString());
  }
  return image;
}

Future<String> storeFileToFirebase(File file, String name) async {
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  UploadTask uploadTask = firebaseStorage.ref("images/$name").putFile(file);
  TaskSnapshot snap = await uploadTask;
  String downloadUrl = await snap.ref.getDownloadURL();
  return downloadUrl;
}
