import 'package:flutter/material.dart';
import 'package:meals/widgets/switch_tile_filter.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  final Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegetarian': false,
    'vegan': false,
  };

  void _changeFilterStatus(String filter, bool isChecked) {
    setState(() {
      _filters[filter] = isChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Filters"),
      ),
      body: PopScope(
        canPop: true,
        onPopInvoked: (bool didPop) {
          if (didPop) return;
          Navigator.of(context).pop({
            Filter.glutenFree: _filters['gluten'],
            Filter.lactoseFree: _filters['lactose'],
            Filter.vegetarian: _filters['vegetarian'],
            Filter.vegan: _filters['vegan'],
          });
        },
        /**
 * PopScope(
  canPop: false,
  onPopInvoked: (bool didPop) {
    if(didPop) return;
    Navigator.of(context).pop({
      Filter.glutenFree: _glutenFreeFilterSet,
      Filter.lactoseFree: _lactoseFreeFilterSet,
      Filter.vegetarian: _vegetarianFilterSet,
      Filter.vegan: _veganFilterSet,
    });
  },
  child: Column(...) // same code as shown in the next lecture
),
 */
        child: Column(
          children: [
            SwitchTileFilter(
              glutenFreeFilterSet: _filters['gluten']!,
              changePropertyStatus: (isChecked) =>
                  _changeFilterStatus('gluten', isChecked),
              title: "Gluten-free",
              subtitle: "Only include gluten-free meals.",
            ),
            SwitchTileFilter(
              glutenFreeFilterSet: _filters['lactose']!,
              changePropertyStatus: (isChecked) =>
                  _changeFilterStatus('lactose', isChecked),
              title: "Lactose-free",
              subtitle: "Only include lactose-free meals.",
            ),
            SwitchTileFilter(
              glutenFreeFilterSet: _filters['vegetarian']!,
              changePropertyStatus: (isChecked) =>
                  _changeFilterStatus('vegetarian', isChecked),
              title: "Vegetarian",
              subtitle: "Only include vegetarian meals.",
            ),
            SwitchTileFilter(
              glutenFreeFilterSet: _filters['vegan']!,
              changePropertyStatus: (isChecked) =>
                  _changeFilterStatus('vegan', isChecked),
              title: "Vegan",
              subtitle: "Only include vegan meals.",
            ),
          ],
        ),
      ),
    );
  }
}
