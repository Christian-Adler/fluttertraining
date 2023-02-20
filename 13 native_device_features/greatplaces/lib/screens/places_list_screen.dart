import 'package:flutter/material.dart';
import 'package:greatplaces/provider/great_places.dart';
import 'package:greatplaces/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(AddPlaceScreen.routeName),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).fetchAndSetPlaces(),
        builder: (ctx, greatPlacesSnapshot) => greatPlacesSnapshot.connectionState == ConnectionState.waiting
            ? const Center(child: CircularProgressIndicator())
            : Consumer<GreatPlaces>(
                child: const Center(child: Text('No places yet, start adding some!')),
                builder: (context, greatPlaces, ch) => greatPlaces.items.isEmpty
                    ? ch!
                    : ListView.builder(
                        itemBuilder: (ctx, i) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: FileImage(greatPlaces.items[i].image),
                            ),
                            title: Text(greatPlaces.items[i].title),
                            onTap: () {
                              // go to detail
                            },
                            trailing: IconButton(
                              icon: Icon(Icons.delete_outline_rounded, color: Theme.of(ctx).colorScheme.error),
                              onPressed: () => greatPlaces.delete(greatPlaces.items[i].id),
                            ),
                          );
                        },
                        itemCount: greatPlaces.items.length),
              ),
      ),
    );
  }
}
