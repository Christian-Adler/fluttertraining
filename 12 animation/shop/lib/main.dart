import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/helpers/custom_route.dart';
import 'package:shop/providers/auth.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/providers/orders.dart';
import 'package:shop/providers/products.dart';
import 'package:shop/screen/auth_screen.dart';
import 'package:shop/screen/cart_screen.dart';
import 'package:shop/screen/edit_product_screen.dart';
import 'package:shop/screen/orders_screen.dart';
import 'package:shop/screen/product_detail_screen.dart';
import 'package:shop/screen/products_overview_screen.dart';
import 'package:shop/screen/user_products_screen.dart';
import 'package:shop/widget/splash_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          update: (ctx, auth, previousProducts) =>
              Products(auth.token, auth.userId, previousProducts == null ? [] : previousProducts.items),
          create: (ctx) => Products(null, null, []),
          // create should be used if a new Object is provided, Less render cycles and .value could lead to buggy behavior
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          update: (context, auth, previousOrders) =>
              Orders(auth.token, auth.userId, previousOrders == null ? [] : previousOrders.orders),
          create: (ctx) => Orders('', '', []),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
          title: 'Shop',
          theme: ThemeData(
            fontFamily: 'Lato',
            // useMaterial3: true,
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple).copyWith(
              secondary: Colors.deepOrange,
              //   onPrimary: Colors.white, Farbe die auf primary verwendet wird.
            ),
            textTheme: Theme.of(context).textTheme,
            pageTransitionsTheme: PageTransitionsTheme(builders: {
              TargetPlatform.android: CustomPageTransitionBuilder(),
              TargetPlatform.iOS: CustomPageTransitionBuilder(),
            }),
          ),
          home: auth.isAuth
              ? const ProductsOverviewScreen()
              : FutureBuilder(
                  builder: (ctx, authResultSnapshot) => authResultSnapshot.connectionState == ConnectionState.waiting
                      ? const SplashScreen()
                      : const AuthScreen(),
                  future: auth.tryAutoLogin(),
                ),
          routes: {
            ProductDetailScreen.routeName: (context) => const ProductDetailScreen(),
            CartScreen.routeName: (context) => const CartScreen(),
            OrdersScreen.routeName: (context) => const OrdersScreen(),
            UserProductsScreen.routeName: (context) => const UserProductsScreen(),
            EditProductScreen.routeName: (context) => const EditProductScreen(),
          },
        ),
      ),
    );
  }
}
