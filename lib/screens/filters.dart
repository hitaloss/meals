import 'package:flutter/material.dart';

import 'package:meals/widgets/switch_tile_filter.dart';
import 'package:meals/providers/filters_provider.dart';

class FiltersScreen extends StatelessWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Filters"),
      ),
      body: const Column(
        children: [
          SwitchTileFilter(
            filter: Filter.glutenFree,
            title: "Gluten-free",
            subtitle: "Only include gluten-free meals.",
          ),
          SwitchTileFilter(
            filter: Filter.lactoseFree,
            title: "Lactose-free",
            subtitle: "Only include lactose-free meals.",
          ),
          SwitchTileFilter(
            filter: Filter.vegetarian,
            title: "Vegetarian",
            subtitle: "Only include vegetarian meals.",
          ),
          SwitchTileFilter(
            filter: Filter.vegan,
            title: "Vegan",
            subtitle: "Only include vegan meals.",
          ),
        ],
      ),
    );
  }
}
