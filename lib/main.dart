import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_shopper/common/theme.dart';
import 'package:provider_shopper/models/cart_model.dart';
import 'package:provider_shopper/screens/cart_page.dart';
import 'package:provider_shopper/screens/catalog_page.dart';
import 'package:provider_shopper/screens/login_page.dart';
import 'models/catalog_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => CatalogModel(),
        ),
        ChangeNotifierProxyProvider<CatalogModel, CartModel>(
          create: (context) => CartModel(),
          update: (context, catalog, cart) {
            if (cart == null) throw ArgumentError.notNull("cart");
            cart.catalog = catalog;
            return cart;
          },
        ),
      ],
      child: MaterialApp(
          title: "ProviderDemo",
          theme: appTheme,
          initialRoute: "/",
          routes: {
            "/": (context) => MyLogin(),
            "/catalog": (context) => MyCatalog(),
            "/cart": (context) => MyCart()
          }),
    );
  }
}
