import 'package:flutter/material.dart';

class SwitchTileFilter extends StatelessWidget {
  const SwitchTileFilter({
    super.key,
    required this.propertyStatusFilterSet,
    required this.changePropertyStatus,
    required this.title,
    required this.subtitle,
  });

  final bool propertyStatusFilterSet;
  final void Function(bool isChecked) changePropertyStatus;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: propertyStatusFilterSet,
      onChanged: (isChecked) {
        changePropertyStatus(isChecked);
      },
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Theme.of(context).colorScheme.onBackground),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context)
            .textTheme
            .labelMedium!
            .copyWith(color: Theme.of(context).colorScheme.onBackground),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 34, right: 22),
    );
  }
}
