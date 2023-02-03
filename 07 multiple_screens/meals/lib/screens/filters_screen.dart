import 'package:flutter/material.dart';
import 'package:meals/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const String routeName = '/filters';

  const FiltersScreen({Key? key}) : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _lactoseFree = false;
  var _vegan = false;
  var _vegetarian = false;

  Widget _buildFilterSwitch(
      String title, String subTitle, bool value, Function(bool) updateValue) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subTitle),
      value: value,
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              _buildFilterSwitch(
                'Gluten-free',
                'Only include gluten-free meals',
                _glutenFree,
                (val) => setState(() {
                  _glutenFree = val;
                }),
              ),
              _buildFilterSwitch(
                'Lactose-free',
                'Only include lactose-free meals',
                _lactoseFree,
                (val) => setState(() {
                  _lactoseFree = val;
                }),
              ),
              _buildFilterSwitch(
                'Vegan',
                'Only include vegan meals',
                _vegan,
                (val) => setState(() {
                  _vegan = val;
                }),
              ),
              _buildFilterSwitch(
                'Vegetarian',
                'Only include vegetarian meals',
                _vegetarian,
                (val) => setState(() {
                  _vegetarian = val;
                }),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
