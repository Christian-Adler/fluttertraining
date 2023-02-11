import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/products_provider.dart';
import 'package:shop/screen/cart_screen.dart';
import 'package:shop/widget/app_drawer.dart';
import 'package:shop/widget/badge-max.dart';

import '../providers/cart.dart';
import '../widget/products_grid.dart';

enum FilterOptions {
  favorites,
  all,
}

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showFavoritesOnly = false;
  bool _isLoading = true;

  // bool _isInit = true;

  @override
  void initState() {
    // Provider.of<ProductsProvider>(context).fetchAndSetProducts(); // solange nicht listen:false geht das nicht in initState
    // Workaround 1 (durch delayed wird der Inhalt erst ausgefuehrt, nachdem initState fertig ist.
    Future.delayed(Duration.zero).then((_) async {
      await Provider.of<ProductsProvider>(context, listen: false).fetchAndSetProducts();
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // Workaround 2
    // if (_isInit) {
    //   _isInit = false;
    //   Provider.of<ProductsProvider>(context).fetchAndSetProducts();
    // }
    super.didChangeDependencies();
  }

  void _setShowFavorites(bool val) {
    setState(() {
      _showFavoritesOnly = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOptions.favorites,
                child: Text('Only Favorites'),
              ),
              const PopupMenuItem(
                value: FilterOptions.all,
                child: Text('Show all'),
              ),
            ],
            onSelected: (FilterOptions selectedValue) {
              _setShowFavorites(selectedValue == FilterOptions.favorites);
            },
          ),
          Consumer<Cart>(
            builder: (_, cartData, ch) => BadgeMax(
              value: cartData.itemCount.toString(),
              child: ch,
            ),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
          Consumer<Cart>(
            builder: (_, cartData, ch) => Badge(
              isLabelVisible: true,
              label: Text(cartData.itemCount.toString()),
              alignment: AlignmentDirectional.bottomEnd,
              child: ch,
            ),
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              ),
            ),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(_showFavoritesOnly),
    );
  }
}
