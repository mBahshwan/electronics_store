import 'package:ecommerce_flutter/common/constant.dart';
import 'package:ecommerce_flutter/models/productModel.dart';
import 'package:ecommerce_flutter/services/store.dart';
import 'package:ecommerce_flutter/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditProduct extends StatelessWidget {
  static String id = 'EditProduct';
  String? _name, _price, _description, _category;
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  Store _store = Store();
  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
      body: Form(
        key: _globalKey,
        child: ListView(
          children: <Widget>[
            // SizedBox(
            //   height: MediaQuery.of(context).size.height * .2,
            // ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 50, top: 30),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.white),
                    color: kSecondaryColor,
                  ),
                  width: 180,
                  height: 180,
                  child: product.pImage == null
                      ? Text(
                          "there is no image",
                          textAlign: TextAlign.center,
                        )
                      : Image.network(product.pImage!, fit: BoxFit.fill),
                ),

                CustomTextField(
                  icon: Icons.nat,
                  hint: 'Product Name',
                  onClick: (value) {
                    _name = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  icon: Icons.price_check_outlined,
                  onClick: (value) {
                    _price = value;
                  },
                  hint: 'Product Price',
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  icon: Icons.description,
                  onClick: (value) {
                    _description = value;
                  },
                  hint: 'Product Description',
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  icon: Icons.category,
                  onClick: (value) {
                    _category = value;
                  },
                  hint: 'Product Category',
                ),
                SizedBox(
                  height: 10,
                ),
                // CustomTextField(
                //   icon: Icons.image,
                //   onClick: (value) {
                //     _imageLocation = value;
                //   },
                //   hint: 'Product Location',
                // ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: kSecondaryColor),
                  onPressed: () {
                    if (_globalKey.currentState!.validate()) {
                      _globalKey.currentState!.save();

                      // _store.editProduct({
                      //   kProductName: _name,
                      //   kProductLocation: _imageLocation,
                      //   kProductCategory: _category,
                      //   kProductDescription: _description,
                      //   kProductPrice: _price
                      // }, product.pId);
                      Product _product = Product(
                          pCategory: _category,
                          pDescription: _description,
                          pImage: product.pImage,
                          pName: _name,
                          pPrice: _price,
                          pId: product.pId);
                      _store.editProduct(_product, context);
                      print(product.pName);
                    }
                  },
                  child: Text(
                    'Edit Product',
                    style: TextStyle(color: Colors.black54),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
