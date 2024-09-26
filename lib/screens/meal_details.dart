import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals/models/meal.dart';
import 'package:meals/providers/favorites_provider.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteMealsProvider);

    final isFavorite = favoriteMeals.contains(meal);

    void showInfoMessage(String message) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(milliseconds: 1500),
          content: Text(message)));
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(meal.title),
          actions: [
            IconButton(
              onPressed: () {
                final message = ref
                    .read(favoriteMealsProvider.notifier)
                    .toggleMealFavorite(meal);
                showInfoMessage(message);
              },
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 1000),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: RotationTransition(
                      turns: Tween<double>(begin: 0.3, end: 1.0).animate(
                        CurvedAnimation(
                          parent: animation,
                          curve:
                              const Interval(0.0, 0.7, curve: Curves.easeInOut),
                        ),
                      ),
                      child: ScaleTransition(
                        scale: Tween<double>(begin: 0.9, end: 1.2).animate(
                          CurvedAnimation(
                            parent: animation,
                            curve: const Interval(0.7, 1.0,
                                curve: Curves.easeOutBack),
                          ),
                        ),
                        child: child,
                      ),
                    ),
                  );
                },
                child: Icon(
                  isFavorite ? Icons.star : Icons.star_border,
                  color: isFavorite ? Colors.yellow : null,
                  key: ValueKey(isFavorite),
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Hero(
                tag: meal.id,
                child: Image.network(
                  meal.imageUrl,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                "Ingredients",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 14),
              for (final ingredients in meal.ingredients)
                Text(
                  ingredients,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              const SizedBox(height: 24),
              Text(
                "Steps",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 14),
              for (final step in meal.steps)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Text(
                    step,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                ),
            ],
          ),
        ));
  }
}
