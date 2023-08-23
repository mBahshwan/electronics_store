import 'package:ecommerce_flutter/common/constant.dart';
import 'package:ecommerce_flutter/provider/adminMode.dart';
import 'package:ecommerce_flutter/provider/cartItem.dart';
import 'package:ecommerce_flutter/screens/admin/addProducts.dart';
import 'package:ecommerce_flutter/screens/admin/adminHome.dart';
import 'package:ecommerce_flutter/screens/admin/editProduct.dart';
import 'package:ecommerce_flutter/screens/admin/manageProduct.dart';
import 'package:ecommerce_flutter/screens/admin/orderScreen.dart';
import 'package:ecommerce_flutter/screens/loginScreen.dart';
import 'package:ecommerce_flutter/screens/signupScreen.dart';
import 'package:ecommerce_flutter/screens/user/cartScreen.dart';
import 'package:ecommerce_flutter/screens/user/homePage.dart';
import 'package:ecommerce_flutter/screens/user/productInfo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  bool isUserLoggedIn = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text('Loading....'),
              ),
            ),
          );
        } else {
          isUserLoggedIn = snapshot.data!.getBool(kKeepMeLoggedIn) ?? false;
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<CartItem>(
                create: (context) => CartItem(),
              ),
              ChangeNotifierProvider<AdminMode>(
                create: (context) => AdminMode(),
              )
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: isUserLoggedIn ? HomePage.id : LoginScreen.id,
              routes: {
                OrdersScreen.id: (context) => OrdersScreen(),
                CartScreen.id: (context) => CartScreen(),
                ProductInfo.id: (context) => ProductInfo(),
                EditProduct.id: (context) => EditProduct(),
                ManageProducts.id: (context) => ManageProducts(),
                LoginScreen.id: (context) => LoginScreen(),
                SignupScreen.id: (context) => SignupScreen(),
                HomePage.id: (context) => HomePage(),
                AdminHome.id: (context) => AdminHome(),
                AddProduct.id: (context) => AddProduct(),
              },
            ),
          );
        }
      },
    );
  }
}
