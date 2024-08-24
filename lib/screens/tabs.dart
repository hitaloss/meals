import 'package:flutter/material.dart';
// import 'package:meals/data/dummy_data.dart';

import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/main_drawer.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];
  // Map<Filter, bool> _selectedFilters = {
  //   Filter.glutenFree: false,
  //   Filter.lactoseFree: false,
  //   Filter.vegetarian: false,
  //   Filter.vegan: false,
  // };

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    if (_favoriteMeals.contains(meal)) {
      setState(() {
        _favoriteMeals.remove(meal);
      });
      _showInfoMessage("Meal unmarked as favorite.");
    } else {
      setState(() {
        _favoriteMeals.add(meal);
      });
      _showInfoMessage("Marked as favorite!");
    }
  }

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(milliseconds: 1500), content: Text(message)));
  }

  void _setScreen(String identifier) async {
    Navigator.pop(context);
    if (identifier == 'filters') {
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (ctx) => const FiltersScreen()));
      /*final result = await */ Navigator.push<Map<Filter, bool>>(
          context, MaterialPageRoute(builder: (ctx) => const FiltersScreen()));

      // setState(() {
      //   _selectedFilters = result ?? kInitialFilters;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    // final availableMeals = dummyMeals.where((meal) {
    //   if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
    //     return false;
    //   }
    //   if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
    //     return false;
    //   }
    //   if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
    //     return false;
    //   }
    //   if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
    //     return false;
    //   }
    //   return true;
    // }).toList();

    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleMealFavoriteStatus,
    );
    var activePageTitle = "Categories";

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favoriteMeals,
        onToggleFavorite: _toggleMealFavoriteStatus,
      );
      activePageTitle = "Your Favorites";
    }

    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      body: activePage,
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: _selectPage,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorites"),
        ],
      ),
    );
  }
}
