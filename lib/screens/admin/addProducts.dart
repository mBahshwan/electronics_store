import 'dart:io';
import 'package:ecommerce_flutter/common/constant.dart';
import 'package:ecommerce_flutter/functions.dart';
import 'package:ecommerce_flutter/services/store.dart';
import 'package:ecommerce_flutter/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AddProduct extends StatefulWidget {
  static String id = 'AddProduct';

//  AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String? _name, _price, _description, _category;

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  Store _store = Store();

  File? image;
  void selectImage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _globalKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: selectImage,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.white),
                    color: kSecondaryColor,
                  ),
                  width: 180,
                  height: 180,
                  child: image == null
                      ? Text(
                          "there is no image",
                          textAlign: TextAlign.center,
                        )
                      : Image.file(image!, fit: BoxFit.fill),
                ),
              ),
              SizedBox(
                height: 30,
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
                icon: Icons.price_check_rounded,
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
              MaterialButton(
                onPressed: () async {
                  if (_globalKey.currentState!.validate()) {
                    _globalKey.currentState!.save();

                    await _store.saveUserDataToFirebase(
                      imageFile: image,
                      category: _category!,
                      price: _price!,
                      description: _description!,
                      name: _name!,
                      context: context,
                    );

                    // _store.addProduct(Product(
                    //     pName: _name,
                    //     pPrice: _price,
                    //     pDescription: _description,
                    //     pImage: image!.path,
                    //     pCategory: _category));
                  }
                },
                child: Text('Add Product'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
