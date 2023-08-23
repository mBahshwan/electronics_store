// import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecommerce_flutter/common/constant.dart';
import 'package:ecommerce_flutter/models/productModel.dart';
import 'package:ecommerce_flutter/screens/loginScreen.dart';
import 'package:ecommerce_flutter/screens/user/cartScreen.dart';
import 'package:ecommerce_flutter/screens/user/productInfo.dart';
import 'package:ecommerce_flutter/services/auth.dart';
import 'package:ecommerce_flutter/services/store.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  static String id = 'HomePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = Auth();
  // User? _loggedUser;
  int _tabBarIndex = 0;
  int _bottomBarIndex = 0;
  final _store = Store();
  // List<Product>? _products;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        DefaultTabController(
          length: 3,
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: kUnActiveColor,
              currentIndex: _bottomBarIndex,
              fixedColor: kMainColor,
              onTap: (value) async {
                if (value == 2) {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  pref.clear();
                  await _auth.signOut();
                  Navigator.popAndPushNamed(context, LoginScreen.id);
                }
                setState(() {
                  _bottomBarIndex = value;
                });
              },
              items: [
                BottomNavigationBarItem(
                    label: 'Test', icon: Icon(Icons.person)),
                BottomNavigationBarItem(
                    label: 'Test', icon: Icon(Icons.person)),
                BottomNavigationBarItem(
                    label: 'Sign Out', icon: Icon(Icons.close)),
              ],
            ),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              bottom: TabBar(
                indicatorColor: kMainColor,
                onTap: (value) {
                  setState(() {
                    _tabBarIndex = value;
                  });
                },
                tabs: <Widget>[
                  Text(
                    'mobile',
                    style: TextStyle(
                      color: _tabBarIndex == 0 ? Colors.black : kUnActiveColor,
                      fontSize: _tabBarIndex == 0 ? 16 : null,
                    ),
                  ),
                  Text(
                    'labtop',
                    style: TextStyle(
                      color: _tabBarIndex == 1 ? Colors.black : kUnActiveColor,
                      fontSize: _tabBarIndex == 1 ? 16 : null,
                    ),
                  ),
                  Text(
                    'camera',
                    style: TextStyle(
                      color: _tabBarIndex == 2 ? Colors.black : kUnActiveColor,
                      fontSize: _tabBarIndex == 2 ? 16 : null,
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                viewProducts("mobile"),
                viewProducts("labtop"),
                viewProducts("camera")
                // jacketView(),
                // ProductsView(kTrousers),
                // ProductsView(kShoes),
                // ProductsView(kTshirts),
                // Container(
                //   child: Text("one"),
                // ),
                // Container(
                //   child: Text("two"),
                // ),
                // Container(
                //   child: Text("three"),
                // ),
              ],
            ),
          ),
        ),
        Material(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Container(
              height: MediaQuery.of(context).size.height * .1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Discover'.toUpperCase(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, CartScreen.id);
                      },
                      child: Icon(Icons.shopping_cart))
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  // @override
  // void initState() {
  //   super.initState();
  //   getCurrenUser();
  // }

  // getCurrenUser() async {
  //   _loggedUser = await FirebaseAuth.instance.currentUser;
  // }

  Widget viewProducts(String category) {
    return FutureBuilder<List<Product>>(
      future: _store.loadProducts().then((value) =>
          value.where((element) => element.pCategory == category).toList()),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // List<Product> products = [];
          // for (var doc in snapshot.data!) {
          //   var data = doc.data;
          //   products.add(Product(
          //       pId: doc.documentID,
          //       pPrice: data[kProductPrice],
          //       pName: data[kProductName],
          //       pDescription: data[kProductDescription],
          //       pLocation: data[kProductLocation],
          //       pCategory: data[kProductCategory]));
          // }
          // _products = [...products];
          // products.clear();
          // products = getProductByCategory(kJackets, _products!);
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: .8,
            ),
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ProductInfo.id,
                      arguments: snapshot.data![index]);
                },
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Image(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            snapshot.data![index].pImage.toString()),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Opacity(
                        opacity: .6,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  snapshot.data![index].pName.toString(),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('\$ ${snapshot.data![index].pPrice}')
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            itemCount: snapshot.data!.length,
          );
        } else {
          return Center(child: Text('Loading...'));
        }
      },
    );
  }
}
