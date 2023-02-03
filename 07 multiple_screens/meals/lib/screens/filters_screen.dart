import 'package:flutter/material.dart';
import 'package:meals/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const String routeName = '/filters';
  final Map<String, bool> currentFilters;
  final Function(Map<String, bool> filters) saveFilters;

  const FiltersScreen(this.currentFilters, this.saveFilters, {Key? key})
      : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _lactoseFree = false;
  var _vegan = false;
  var _vegetarian = false;

  @override
  initState() {
    super.initState();
    _glutenFree = widget.currentFilters['glutenFree'] as bool;
    _lactoseFree = widget.currentFilters['lactoseFree'] as bool;
    _vegan = widget.currentFilters['vegan'] as bool;
    _vegetarian = widget.currentFilters['vegetarian'] as bool;
  }

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
        actions: [
          IconButton(
              onPressed: () {
                final filters = {
                  'glutenFree': _glutenFree,
                  'lactoseFree': _lactoseFree,
                  'vegan': _vegan,
                  'vegetarian': _vegetarian,
                };
                widget.saveFilters(filters);
              },
              icon: const Icon(Icons.save))
        ],
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
