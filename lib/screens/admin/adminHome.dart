import 'package:ecommerce_flutter/common/constant.dart';
import 'package:ecommerce_flutter/screens/admin/addProducts.dart';
import 'package:ecommerce_flutter/screens/admin/manageProduct.dart';
import 'package:ecommerce_flutter/screens/admin/orderScreen.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatelessWidget {
  static String id = 'AdminHome';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: double.infinity,
          ),
          MaterialButton(
            color: kSecondaryColor,
            onPressed: () {
              Navigator.pushNamed(context, AddProduct.id);
            },
            child: Text('Add Product'),
          ),
          MaterialButton(
            color: kSecondaryColor,
            onPressed: () {
              Navigator.pushNamed(context, ManageProducts.id);
            },
            child: Text('Edit Product'),
          ),
          MaterialButton(
            color: kSecondaryColor,
            onPressed: () {
              Navigator.pushNamed(context, OrdersScreen.id);
            },
            child: Text('View orders'),
          )
        ],
      ),
    );
  }
}
