import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/widget/order_list_item.dart';

import '../providers/orders.dart';
import '../widget/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        builder: (czx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (dataSnapshot.hasError) {
              // .. do error handling
              return const Center(
                child: Text('Error occurred'),
              );
            } else {
              return Consumer<Orders>(
                  builder: (ctx, ordersData, child) => ListView.builder(
                      itemBuilder: (context, index) {
                        return OrderListItem(ordersData.orders[index]);
                      },
                      itemCount: ordersData.orders.length));
            }
          }
        },
      ),
    );
  }
}
