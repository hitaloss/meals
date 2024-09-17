import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals/widgets/switch_tile_filter.dart';
import 'package:meals/providers/filters_provider.dart';

class FiltersScreen extends ConsumerStatefulWidget {
  const FiltersScreen({super.key});

  @override
  ConsumerState<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends ConsumerState<FiltersScreen> {
  final Map<String, bool> _filters = {};

  @override
  void initState() {
    super.initState();
    final activeFilters = ref.read(filtersProvider);
    _filters['gluten'] = activeFilters[Filter.glutenFree]!;
    _filters['lactose'] = activeFilters[Filter.lactoseFree]!;
    _filters['vegetarian'] = activeFilters[Filter.vegetarian]!;
    _filters['vegan'] = activeFilters[Filter.vegan]!;
  }

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
          ref.read(filtersProvider.notifier).setFilters({
            Filter.glutenFree: _filters['gluten']!,
            Filter.lactoseFree: _filters['lactose']!,
            Filter.vegetarian: _filters['vegetarian']!,
            Filter.vegan: _filters['vegan']!,
          });
        },
        child: Column(
          children: [
            SwitchTileFilter(
              propertyStatusFilterSet: _filters['gluten']!,
              changePropertyStatus: (isChecked) =>
                  _changeFilterStatus('gluten', isChecked),
              title: "Gluten-free",
              subtitle: "Only include gluten-free meals.",
            ),
            SwitchTileFilter(
              propertyStatusFilterSet: _filters['lactose']!,
              changePropertyStatus: (isChecked) =>
                  _changeFilterStatus('lactose', isChecked),
              title: "Lactose-free",
              subtitle: "Only include lactose-free meals.",
            ),
            SwitchTileFilter(
              propertyStatusFilterSet: _filters['vegetarian']!,
              changePropertyStatus: (isChecked) =>
                  _changeFilterStatus('vegetarian', isChecked),
              title: "Vegetarian",
              subtitle: "Only include vegetarian meals.",
            ),
            SwitchTileFilter(
              propertyStatusFilterSet: _filters['vegan']!,
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
